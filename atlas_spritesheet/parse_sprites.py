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
