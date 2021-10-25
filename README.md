# Ryu Game

* Build with Solar2D (Lua)

To generate the spritesheet atlas automatically (since I was only provided the spritesheet)
* First, photo edit and delete all the text labels that are not the frames
* Then upload the photo to Leshy Spritesheet Tool (https://www.leshylabs.com/apps/sstool/)
  * Click the 'Remap' button
  * Check the 'Show Outline' checkbox to view the individual frames
  * Then, I clicked on each frame, and changed the 'Name' in 'Sprite Settings' to the frame number (1 to n)
  * Then at the bottom, change the dropdown from "Text" to "JSON-TP-Hash"
  * And click the bottom 'Save' button to export the .json file
  * Then I wrote a Python script to parse the .json file, and generate a valid Lua table that works with Solar2D imageSheet

```python
from pprint import pprint
import json
filename = "sprites_ordered.json"


with open(filename, "r") as f:
    frames_dict = json.load(f)["frames"]
    new_frames_dict = {}

    frames_arr = [None] * (len(frames_dict) + 1)

    for spriteName, cur_frame_dict in frames_dict.items():
        cur_frame_dimensions = cur_frame_dict["frame"]

        spriteNumber = int(spriteName)
        frames_arr[spriteNumber] = {
            'x': cur_frame_dimensions["x"],
            'y': cur_frame_dimensions['y'],
            'width': cur_frame_dimensions['w'],
            'height': cur_frame_dimensions['h']
        }

    del frames_arr[0]
    # print(frames_arr)

    # with open('atlas.txt', 'w') as f:
    #     json.dump(frames_arr, f)

    lua_array_text = json.dumps(frames_arr).replace(
        ":", "=").replace('[', '{').replace("]", "}").replace('"', '')
    print(lua_array_text)

```