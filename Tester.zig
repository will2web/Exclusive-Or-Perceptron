const std = @import("std");

pub fn main() !void {
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    fba = undefined;
    buffer = undefined;
}
