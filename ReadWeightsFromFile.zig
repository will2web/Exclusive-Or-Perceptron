const std = @import("std");

const fs = std.fs;
const io = std.io;
const BoundedArray = std.BoundedArray;

const filename = "C:/Users/wresc/ZigProjects/Neural Network/Neural-Network/weights.json"; // Replace with the actual path

pub fn main() !void {
    const weightStruct = struct { Weight0: f32, Weight1: f32, Weight2: f32 };
    const json_weights = weightStruct{
        .Weight0 = 1,
        .Weight1 = 2,
        .Weight2 = 3,
    };

    var json_buffer: [1024]u8 = undefined;
    var json_fba = std.heap.FixedBufferAllocator.init(&json_buffer);
    var json_writer = std.ArrayList(u8).init(json_fba.allocator());
    try std.json.stringify(json_weights, .{}, json_writer.writer());
    std.debug.print("json_weights: {any}\n", .{json_weights});

    var file = try fs.openFileAbsolute(filename, .{});
    defer file.close();

    const stat = try file.stat();
    const file_size = stat.size;
    const buffer = try std.heap.page_allocator.alloc(u8, file_size);
    defer std.heap.page_allocator.free(buffer);
    _ = try file.readAll(buffer);
    std.debug.print("File content: {s}\n", .{buffer});
}
