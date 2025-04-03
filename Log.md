Can't decide if I want to stringify the weights array or the struct....

4/2/2025
-Moved JSON creation & file save to it's own function
-removed (maybe temporarily) the JSON weights struct

4/1/2025
-Added code to create struct from weights array, convert struct to JSON format and save JSON file.
    Create, Read & Write File code adapted from: https://www.reddit.com/r/Zig/comments/1fsr9gb/how_to_create_read_and_write_files_in_zig/
    Json Code adapted from: https://www.huy.rocks/everyday/01-09-2022-zig-json-in-5-minutes
    AND
    https://zig.guide/standard-library/json/
