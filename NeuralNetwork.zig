const std = @import("std");

pub fn main() !void {
    const learningRate = 1;
    const bias = 1;
    var x: i3 = undefined;

    x = learningRate + bias;

    std.debug.print("{d}\n", .{x});
}
