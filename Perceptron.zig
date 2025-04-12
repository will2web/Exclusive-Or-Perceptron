const std = @import("std");
const filename = "C:/Users/wresc/ZigProjects/Neural Network/Neural-Network/weights.json";

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Is input 1 true or false? ", .{});
    var decision1: [7]u8 = undefined;
    const result1 = try stdin.readUntilDelimiter(&decision1, '\n');
    const decision1_slice = std.mem.sliceTo(&decision1, '\r');
    var decision1_value: bool = undefined;
    if (std.mem.eql(u8, decision1_slice, "true")) {
        decision1_value = true;
    } else {
        decision1_value = false;
    }

    //Trying to convert byte array to string...
    //using the result ("result1") of readUntilDelimiter instead of the buffer
    //using result.len with buffer might be an in-between solution
    //maybe re encode in unicode
    //https://ziglang.org/documentation/0.14.0/std/#std.unicode
    std.debug.print("result1 is {c}", .{result1});

    try stdout.print("Is input 2 true or false? ", .{});
    var decision2: [7]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision2, '\n');
    const decision2_slice = std.mem.sliceTo(&decision2, '\r');
    var decision2_value: bool = undefined;
    if (std.mem.eql(u8, decision2_slice, "true")) {
        decision2_value = true;
    } else {
        decision2_value = false;
    }

    var file = try std.fs.openFileAbsolute(filename, .{});
    defer file.close();
    const stat = try file.stat();
    const file_size = stat.size;
    const allocator = std.heap.page_allocator;
    const buffer = try allocator.alloc(u8, file_size);
    defer std.heap.page_allocator.free(buffer);
    _ = try file.readAll(buffer);

    const weightStruct = struct { Weight0: f32, Weight1: f32, Weight2: f32 };

    const parsed = try std.json.parseFromSlice(
        weightStruct,
        allocator,
        buffer,
        .{},
    );
    defer parsed.deinit();
    const file_weights = parsed.value;

    const trained_weights = [_]f32{ file_weights.Weight0, file_weights.Weight1, file_weights.Weight2 };

    //                          BELOW debugging prints
    //std.debug.print("File content: {s}\n\n", .{buffer});
    //std.debug.print("Parsed: {any}\n\n", .{parsed.value});
    //std.debug.print("Weight0: {any}\n\n", .{file_weights.Weight0});
    //std.debug.print("trained_weights: {any}\n\n", .{trained_weights});
    //                          ABOVE debugging prints

    try perceptron(&trained_weights, decision1_value, decision2_value, stdout);
}

fn perceptron(primed_weights: []const f32, input1: bool, input2: bool, stdout: anytype) !void {
    const bias = 1;

    const first_input: f32 = switch (input1) {
        false => 0.0,
        true => 1.0,
    };

    const second_input: f32 = switch (input2) {
        false => 0.0,
        true => 1.0,
    };

    const outputP: f32 = first_input * primed_weights[0] + second_input * primed_weights[1] + bias * primed_weights[2];

    const output = outputP > 0;

    try stdout.print("{any} or {any} is {any}", .{ input1, input2, output });
}
