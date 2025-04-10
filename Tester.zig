const std = @import("std");

pub const Message = union(enum) {
    text: []const u8,
    number: i32,
    quit: void,
};

pub fn processMessage(message: Message) void {
    switch (message) {
        .text => |text| {
            std.debug.print("Text: {s}\n", .{text});
        },
        .number => |number| {
            std.debug.print("Number: {d}\n", .{number});
        },
        .quit => std.debug.print("Quit\n", .{}),
    }
}

pub fn main() !void {
    processMessage(.{ .text = "Hello, Zig!" });
    processMessage(.{ .number = 42 });
    processMessage(.{ .quit = {} });
}
