const std = @import("std");
const filename = "C:/Users/wresc/ZigProjects/Neural Network/Neural-Network/weights.json";
const Choice = enum {
    No,
    Yes,
};

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Is the 1st input Yes or No? ", .{});
    var decision1: [5]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision1, '\n');
    const decision1_slice = std.mem.sliceTo(&decision1, '\r');
    var decision1_value: f32 = undefined;
    if (std.mem.eql(u8, decision1_slice, "Yes")) {
        decision1_value = 1;
    } else {
        decision1_value = 0;
    }

    //2 lines are to compare enum to float;Just not sure if this or Boolean is better...
    const choice1 = @as(i2, @intFromFloat(decision1_value)) == @as(i2, @intFromEnum(Choice.No));
    std.debug.print("choice1 {any}\n", .{choice1});

    try stdout.print("Is the 2nd input Yes or No? ", .{});
    var decision2: [5]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision2, '\n');
    const decision2_slice = std.mem.sliceTo(&decision2, '\r');
    var decision2_value: f32 = undefined;
    if (std.mem.eql(u8, decision2_slice, "Yes")) {
        decision2_value = 1;
    } else {
        decision2_value = 0;
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

    var trained_weights = [_]f32{ file_weights.Weight0, file_weights.Weight1, file_weights.Weight2 };

    //                          BELOW debugging prints
    //std.debug.print("File content: {s}\n\n", .{buffer});
    //std.debug.print("Parsed: {any}\n\n", .{parsed.value});
    //std.debug.print("Weight0: {any}\n\n", .{file_weights.Weight0});
    //std.debug.print("trained_weights: {any}\n\n", .{trained_weights});
    //                          ABOVE debugging prints

    try perceptron(&trained_weights, decision1_value, decision2_value, stdout);
}

fn perceptron(primed_weights: []f32, input1: f32, input2: f32, stdout: anytype) !void {
    const bias = 1;
    var outputP: f32 = input1 * primed_weights[0] + input2 * primed_weights[1] + bias * primed_weights[2];

    if (outputP > 0) {
        outputP = 1;
    } else {
        outputP = 0;
    }

    try stdout.print("{d} or {d} is {d}", .{ input1, input2, outputP });
}
