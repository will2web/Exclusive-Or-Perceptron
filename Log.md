-still need to include function/variable improvements in Perceptron_Training.zig
-PLAY AROUND WITH @TypeOf FOR STRINGS & ESPECIALLY CONST STRINGS
-Ask Gemini about the different kinds of allocators
-See if I can use size of user input To dynamically but efficiently Allocate memory
-How can I see how much memory is being used by a program?
-How can I test for memory leaks?
-When I do Input validation, I can convert input back to U2 instead of float 32
-Maybe have a perceptron function return the answer as its type instead of using any standard in or standard out in it
-posix is not really meant to be used on Windows; might try to wait to test for the operating system and then use appropriate random seed generator
-comment code

READ
https://zig.guide/standard-library/json/
https://www.huy.rocks/everyday/01-09-2022-zig-json-in-5-minutes
https://www.openmymind.net/Reading-A-Json-Config-In-Zig/
https://ziggit.dev/t/resources-for-parsing-json-strings/1276/3

https://zig.guide/standard-library/allocators/
https://stackoverflow.com/questions/68368122/how-to-read-a-file-in-zig#:~:text=The%20above%20is%20a%20little,2/%23readers-and-writers
https://pedropark99.github.io/zig-book/Chapters/01-zig-weird.html
https://ziglearn.org/chapter-1/


RESOURCES

4/12/2025
-Commenting out "string1" & associated code as inefficient & not needed unless debugging
-Moved file open code to function

4/12/2025
-Converted result1 to string format in "string1": const string1 = std.unicode.fmtUtf8(result1);

4/11/2025
-In order to simplify code,changed user input conversion to Boolean instead of int or enum; Moved some logic down to perception and used switched statements for performance

4/10/2025
-Removed global variables, and unused variables & code left from Perceptron_Training.zig
-Included prototype code to compare choice to Enum

4/9/2025
Utilized trained weights: Opened, read in weights.json file & Use them to correctly predict Exclusive Or function!

4/8/2025
reading in weights from file

4/6/2025
Converted no and yes inputs to zeros and one's, and passed standard-in instance to perceptron function

4/5/2025
Got the standard input working by using mem.sliceTo instead of mem.trim


4/3/2025
Started building actual Perceptron. Mostly just getting the input & output working in Zig
Learned the Input/Out basics from https://medium.com/@eddo2626/lets-learn-zig-1-using-stdout-and-stdin-842ee641cd

4/2/2025
-Moved JSON creation & file save to it's own function
-removed (maybe temporarily) the JSON weights struct

4/1/2025
-Added code to create struct from weights array, convert struct to JSON format and save JSON file.
    Create, Read & Write File code adapted from: https://www.reddit.com/r/Zig/comments/1fsr9gb/how_to_create_read_and_write_files_in_zig/
    Json Code adapted from: https://www.huy.rocks/everyday/01-09-2022-zig-json-in-5-minutes
    AND
    https://zig.guide/standard-library/json/
