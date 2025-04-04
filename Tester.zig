const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Is the 1st input Yes or No? ", .{});

    var decision1: [1024]u8 = undefined; // Increase buffer size
    const bytes_read = try stdin.readUntilDelimiter(&decision1, '\n');

    const decision1_slice = std.mem.sliceTo(decision1[0..bytes_read], '\r') catch decision1[0..bytes_read];

    const decision1_trim = std.mem.trim(u8, decision1_slice, "\r\n");

    try stdout.print("{s}\n", .{decision1_trim});
}
