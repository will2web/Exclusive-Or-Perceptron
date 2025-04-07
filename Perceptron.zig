const std = @import("std");
const learningRate = 1;
var seed: u64 = undefined;
const bias = 1;
var weights: [3]f32 = undefined;
var weightSum: f32 = undefined;

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
        std.debug.print("Failed to get random seed: {}\n", .{err});
        return;
    };

    var prng = std.Random.DefaultPrng.init(seed);
    var rand = prng.random();

    weights = [_]f32{ rand.float(f32), rand.float(f32), rand.float(f32) };

    std.debug.print("\nInitial Weights: {d}\n", .{weights});
    weightSum = weights[0] + weights[1] + weights[2];
    std.debug.print("WeightSum: {d}\n\n", .{weightSum});

    std.debug.print("Is the 1st input Yes or No? ", .{});

    var decision1: [5]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision1, '\n');
    const decision1_slice = std.mem.sliceTo(&decision1, '\r');
    var decision1_value: f32 = undefined;
    if (std.mem.eql(u8, decision1_slice, "Yes")) {
        decision1_value = 1;
    } else {
        decision1_value = 0;
    }

    std.debug.print("Is the 2nd input Yes or No? ", .{});
    var decision2: [5]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision2, '\n');
    const decision2_slice = std.mem.sliceTo(&decision2, '\r');
    var decision2_value: f32 = undefined;
    if (std.mem.eql(u8, decision2_slice, "Yes")) {
        decision2_value = 1;
    } else {
        decision2_value = 0;
    }

    // try stdout.print("{s}\n", .{decision1_slice});
    // try stdout.print("{s}\n", .{decision2_slice});

    try perceptron(decision1_value, decision2_value, stdout);

    //const weightsFiles = open file or read file?
    //print contents of file
    //need to parse to JSON
    //need to allocate Space on the heap like I did with write file
    //seems I Need to deallocate both the opening of the file and the parsing of JSON data
    //assign weights to
}

fn perceptron(input1: f32, input2: f32, stdout: anytype) !void {
    var outputP: f32 = input1 * weights[0] + input2 * weights[1] + bias * weights[2];

    if (outputP > 0) {
        outputP = 1;
    } else {
        outputP = 0;
    }

    try stdout.print("{d} or {d} is {d}", .{ input1, input2, outputP });
}
