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

end

scene:addEventListener("create", scene);

return scene;
