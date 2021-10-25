local composer = require("composer");
local widget = require("widget");
local math = require("math");
local audio = require("audio");

local scene = composer.newScene();

-- Radio Buttons will set this value
local lowSelected = false;

function scene:create(event)
    local sceneGroup = self.view;
    local params = event.params;

    -- Load Background Image
    local backgroundImage = display.newImageRect(sceneGroup, "background.jpg", system.ResourceDirectory,
        display.contentWidth, display.contentHeight);
    backgroundImage.anchorX = 0;
    backgroundImage.anchorY = 0;
    backgroundImage.width = display.contentWidth;
    backgroundImage.height = display.contentHeight;

    -- Load Ryu Image
    local ryuImageSheet = graphics.newImageSheet("Ryu.png", system.ResourceDirectory, {
        frames = {{
            x = 6,
            y = 18,
            width = 43,
            height = 81
        }, {
            x = 55,
            y = 19,
            width = 43,
            height = 80
        }, {
            x = 105,
            y = 18,
            width = 43,
            height = 81
        }, {
            x = 154,
            y = 17,
            width = 43,
            height = 82
        }, {
            x = 205,
            y = 24,
            width = 43,
            height = 75
        }, {
            x = 252,
            y = 19,
            width = 43,
            height = 80
        }, {
            x = 301,
            y = 18,
            width = 43,
            height = 81
        }, {
            x = 351,
            y = 19,
            width = 43,
            height = 80
        }, {
            x = 401,
            y = 19,
            width = 43,
            height = 80
        }, {
            x = 3,
            y = 134,
            width = 43,
            height = 81
        }, {
            x = 52,
            y = 134,
            width = 57,
            height = 81
        }, {
            x = 117,
            y = 134,
            width = 43,
            height = 81
        }, {
            x = 170,
            y = 134,
            width = 43,
            height = 81
        }, {
            x = 218,
            y = 130,
            width = 51,
            height = 85
        }, {
            x = 274,
            y = 130,
            width = 72,
            height = 85
        }, {
            x = 353,
            y = 130,
            width = 51,
            height = 85
        }, {
            x = 411,
            y = 134,
            width = 43,
            height = 81
        }, {
            x = 6,
            y = 261,
            width = 49,
            height = 85
        }, {
            x = 62,
            y = 259,
            width = 67,
            height = 87
        }, {
            x = 135,
            y = 261,
            width = 49,
            height = 85
        }, {
            x = 195,
            y = 265,
            width = 43,
            height = 81
        }, {
            x = 245,
            y = 262,
            width = 55,
            height = 84
        }, {
            x = 306,
            y = 262,
            width = 69,
            height = 84
        }, {
            x = 382,
            y = 276,
            width = 58,
            height = 70
        }, {
            x = 448,
            y = 273,
            width = 43,
            height = 73
        }}
    });

    local animationTime = 500;

    local sequenceData = {{
        name = "idle",
        frames = {1, 2, 3, 4},
        time = animationTime,
        loopCount = 0,
        loopDirection = "forward"
    }, {
        name = "walking",
        frames = {5, 6, 7, 8, 9},
        time = animationTime,
        loopCount = 1
    }, {
        name = "l_punch",
        frames = {10, 11, 12},
        time = animationTime,
        loopCount = 1
    }, {
        name = "mh_punch",
        frames = {13, 14, 15, 16, 17},
        time = animationTime,
        loopCount = 1
    }, {
        name = "lm_kick",
        frames = {18, 19, 20},
        time = animationTime,
        loopCount = 1
    }, {
        name = "h_kick",
        frames = {21, 22, 23, 24, 25},
        time = animationTime,
        loopCount = 1
    }};

    -- Display Ryu on screen
    local ryuSprite = display.newSprite(ryuImageSheet, sequenceData);
    sceneGroup:insert(ryuSprite);
    -- Initial horizontal position is 0
    ryuSprite.x = 0;
    ryuSprite.y = display.contentHeight / 2;
    ryuSprite.anchorX = 0;
    ryuSprite.anchorY = 1;
    -- Initial scale is 1
    ryuSprite:scale(1, 1);

    -- 2 Radio Buttons
    local radioButtonGroup = display.newGroup();
    radioButtonGroup.x = 20;
    radioButtonGroup.y = 230;
    radioButtonGroup.anchorX = 0;
    radioButtonGroup.anchorY = 0;
    radioButtonGroup.anchorChildren = true;

    -- Blue border around radio button group
    local radioGroupBorder = display.newRoundedRect(radioButtonGroup, 0, 0, 90, 80, 20);
    radioGroupBorder.anchorX = 0;
    radioGroupBorder.anchorY = 0;
    radioGroupBorder:setStrokeColor(0.35, 0.62, 0.81);
    radioGroupBorder.strokeWidth = 3;
    radioGroupBorder:setFillColor(1, 0, 1, 0);

    -- Event listener for pressing either radio button
    local function onRadioButtonPress(event)
        local switch = event.target;
        print("Switch with ID" .. switch.id .. " is on " .. tostring(switch.isOn));
        if (switch.id == "lowRadioButton") then
            lowSelected = true;
        else
            lowSelected = false;
        end
    end

    local lowRadioButton = widget.newSwitch({
        style = "radio",
        id = "lowRadioButton",
        initialSwitchState = false,
        onPress = onRadioButtonPress,
        width = 20,
        height = 20
    });
    radioButtonGroup:insert(lowRadioButton);
    lowRadioButton.anchorX = 0;
    lowRadioButton.anchorY = 0;
    lowRadioButton.x = 10;
    lowRadioButton.y = 13;

    local localRadioLabel = display.newText({
        text = "Low",
        x = lowRadioButton.x + 30,
        y = lowRadioButton.y + 5,
        width = 128,
        font = native.systemFont,
        fontSize = 12,
        align = "left"
    });
    radioButtonGroup:insert(localRadioLabel);
    localRadioLabel.anchorX = 0;
    localRadioLabel.anchorY = 0;

    local highRadioButton = widget.newSwitch({
        style = "radio",
        id = "highRadioButton",
        onPress = onRadioButtonPress,
        initialSwitchState = true,
        width = 20,
        height = 20
    });
    radioButtonGroup:insert(highRadioButton);
    highRadioButton.anchorX = 0;
    highRadioButton.anchorY = 0;
    highRadioButton.x = 10;
    highRadioButton.y = 40;

    local highRadioLabel = display.newText({
        text = "High",
        x = highRadioButton.x + 30,
        y = highRadioButton.y + 5,
        width = 128,
        font = native.systemFont,
        fontSize = 12,
        align = "left"
    });
    radioButtonGroup:insert(highRadioLabel);
    highRadioLabel.anchorX = 0;
    highRadioLabel.anchorY = 0;

    -- -- 2 Normal Buttons
    local attackButtonGroup = display.newGroup();
    attackButtonGroup.anchorX = 0;
    attackButtonGroup.anchorY = 0;
    attackButtonGroup.anchorChildren = true;
    attackButtonGroup.x = 200;
    attackButtonGroup.y = 180;

    -- Event listener for pressing Kick Button
    local function onClickKickButton(event)
        local phase = event.phase;
        if (phase == "began") then
            if (lowSelected) then
                -- Do a low kick
                ryuSprite:lm_kick();
            else
                -- Do a high kick
                ryuSprite:h_kick();
            end
        end
    end

    local kickButton = widget.newButton({
        label = "Kick",
        onEvent = onClickKickButton,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 80,
        height = 30,
        cornerRadius = 10,
        fillColor = {
            default = {0.35, 0.62, 0.81},
            over = {0.35, 0.62, 0.81}
        },
        labelColor = {
            default = {1, 1, 1},
            over = {1, 1, 1}
        }
    });
    attackButtonGroup:insert(kickButton);
    kickButton.anchorX = 0;
    kickButton.anchorY = 0;

    -- Event listener for pressing punch button
    local function onClickPunchButton(event)
        local phase = event.phase;
        if (phase == "began") then
            if (lowSelected) then
                -- Do a low punch
                ryuSprite:l_punch();
            else
                -- Do a high punch
                ryuSprite:mh_punch();
            end
        end
    end

    local punchButton = widget.newButton({
        label = "Punch",
        onEvent = onClickPunchButton,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 80,
        height = 30,
        cornerRadius = 10,
        fillColor = {
            default = {0.73, 0, 0},
            over = {0.73, 0, 0}
        },
        labelColor = {
            default = {1, 1, 1},
            over = {1, 1, 1}
        }
    });
    attackButtonGroup:insert(punchButton);
    punchButton.anchorX = 0;
    punchButton.anchorY = 0;
    punchButton.x = kickButton.x + 120;

    -- -- 3 Sliders
    local sliderGroup = display.newGroup();
    sliderGroup.anchorChildren = true;
    sliderGroup.anchorX = 0;
    sliderGroup.anchorY = 0;
    sliderGroup.x = 200;
    sliderGroup.y = attackButtonGroup.y + 30;

    -- Change the scale of the sprite
    local lastScaleValue = 1;
    local function onSlideSize(event)
        local phase = event.phase;

        if (phase == "moved") then
            -- sliderValue goes from 0 to 100
            local sliderValue = event.value;
            -- scaleValue is from 1 to 30
            local scaleValue = math.floor((sliderValue / 100) * 29 + 1);

            -- only make the scale change when there is an integer increment
            if (scaleValue ~= lastScaleValue) then
                -- ryuSprite:scale(scaleValue, scaleValue);
                ryuSprite.xScale = scaleValue;
                ryuSprite.yScale = scaleValue;

                lastScaleValue = scaleValue;
            end
        end

    end

    local sizeSlider = widget.newSlider({
        id = "sizeSlider",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 200,
        value = 0,
        listener = onSlideSize
    });
    sliderGroup:insert(sizeSlider);
    sizeSlider.anchorX = 0;
    sizeSlider.anchorY = 0;

    -- Move Ryu horizontally using slider
    local function onSlideHorizontalMovement(event)
        local sliderValue = event.value;

        -- Play the walking animation when sliding the Horizontal Movement slider
        playSequence(ryuSprite, "walking");

        -- Keep Ryu on the screen, so don't move him to 0
        ryuSprite.x = (sliderValue / 100) * (display.contentWidth - ryuSprite.width * ryuSprite.xScale);
    end

    local hMoveSlider = widget.newSlider({
        id = "hMoveSlider",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 200,
        value = 0,
        listener = onSlideHorizontalMovement
    });
    sliderGroup:insert(hMoveSlider);
    hMoveSlider.anchorX = 0;
    hMoveSlider.anchorY = 0;
    hMoveSlider.y = sizeSlider.y + 30;

    -- Rotate Ryu from 0 deg to 360 deg using slider
    local function onSlideRotate(event)
        local phase = event.phase;

        if (phase == "moved") then
            -- 0 to 100
            local sliderValue = event.value;

            -- rotateValueInDegress from 0 to 360
            local rotateValueInDegrees = (sliderValue / 100) * 360;

            -- set rotation in degrees, different from sprite:rotate()
            ryuSprite.rotation = rotateValueInDegrees;
        end
    end

    local rotateSlider = widget.newSlider({
        id = "rotateSlider",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 200,
        value = 0,
        listener = onSlideRotate
    });
    sliderGroup:insert(rotateSlider);
    rotateSlider.anchorX = 0;
    rotateSlider.anchorY = 0;
    rotateSlider.y = hMoveSlider.y + 30;

    local sliderLabelGroup = display.newGroup();
    sliderLabelGroup.anchorX = 0;
    sliderLabelGroup.anchorY = 0;
    sliderLabelGroup.anchorChildren = true;
    sliderLabelGroup.x = sliderGroup.x - 50;
    sliderLabelGroup.y = sliderGroup.y + 15;
end

scene:addEventListener("create", scene);

return scene;
