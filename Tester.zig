const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const array = [_]i32{ 1, 2, 3, 4 };
    var ptr: [*]const i32 = &array;

    print("ptr[0] == 1: .{any}\n", .{ptr[0] == 1});
    ptr += 1;
    print("ptr[0] == 1: .{any}\n", .{ptr[0] == 2});

    // slicing a many-item pointer without an end is equivalent to
    // pointer arithmetic: `ptr[start..] == ptr + start`
    //try expect(ptr[1..] == ptr + 1);

    // subtraction between any two pointers except slices based on element size is supported
    //try expect(&ptr[1] - &ptr[0] == 1);
}

// pub fn main() !void {
//     var array = [_]u32{ 1, 2, 3 };

//     for (array) |elem| {
//         print("by val: {}\n", .{elem});
//     }

//     for (&array) |*elem| {
//         elem.* += 100;
//         print("by ref: {}\n", .{elem.*});
//     }

//     for (array, &array) |val, *ref| {
//         _ = val;
//         _ = ref;
//     }

//     for (0.., array) |i, elem| {
//         print("{}: {}\n", .{ i, elem });
//     }

//     for (array) |_| {}
// }
