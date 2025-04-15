const std = @import("std");
const filename = "C:/Users/wresc/ZigProjects/Neural Network/Neural-Network/weights.json";

pub fn main() !void {
    var user_inputs: [2]bool = undefined;
    for (user_inputs, 0..) |_, i| {
        user_inputs[i] = try get_user_input(i);
    }

    const read_weights: [3]f32 = try get_weights_from_file();
    try perceptron(&read_weights, &user_inputs);
}

fn get_user_input(input: usize) !bool {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    var choice: [7]u8 = undefined;
    try stdout.print("Is input {} true or false? ", .{input + 1});
    _ = try stdin.readUntilDelimiter(&choice, '\n');
    const choice_slice = std.mem.sliceTo(&choice, '\r');

    const choice_value = std.mem.eql(u8, choice_slice, "true");

    //              Use BELOW 3 lines to debug user input
    //const result: []const u8 = try stdin.readUntilDelimiter(&choice, '\n');
    //const string = std.unicode.fmtUtf8(result);
    //std.debug.print("string is {any}\n", .{string});

    return choice_value;
}

fn get_weights_from_file() ![3]f32 {
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

    //COMMENT 3     BELOW debugging prints
    // std.debug.print("File content: {s}\n\n", .{buffer});
    // std.debug.print("Parsed: {any}\n\n", .{parsed.value});
    //std.debug.print("Weight0: {any}\n\n", .{file_weights.Weight0});
    //COMMENT 3     ABOVE debugging prints

    return [3]f32{ file_weights.Weight0, file_weights.Weight1, file_weights.Weight2 };
}

fn perceptron(weights: []const f32, inputs: []bool) !void {
    const stdout = std.io.getStdOut().writer();
    const bias = 1;

    var input: [2]f32 = undefined;
    for (input, 0..) |_, i| {
        input[i] = switch (inputs[i]) {
            false => 0.0,
            true => 1.0,
        };
    }

    const outputP: f32 = input[0] * weights[0] + input[1] * weights[1] + bias * weights[2];
    const output = outputP > 0;
    try stdout.print("{} or {} is {}\n", .{ inputs[0], inputs[1], output });
}
