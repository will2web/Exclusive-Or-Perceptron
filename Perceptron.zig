const std = @import("std");
const learningRate = 1;
var seed: u64 = undefined;
const bias = 1;
var weights: [3]f32 = undefined;
var weightSum: f32 = undefined;

pub fn main() !void {
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

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    std.debug.print("Is the 1st input Yes or No? ", .{});
    var decision1: [5]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision1, '\n');
    const decision1_trim = std.mem.trim(u8, &decision1, "\r\n");

    //     try stdout.print("Is the 1st input Yes or No? ", .{});
    //     var decision1: [1024]u8 = undefined; // Increase buffer size
    //     const bytes_read = try stdin.readUntilDelimiter(&decision1, '\n');
    //     const decision1_slice = std.mem.sliceTo(decision1[0..bytes_read], '\r') catch decision1[0..bytes_read];
    //     const decision1_trim = std.mem.trim(u8, decision1_slice, "\r\n");
    //     try stdout.print("{s}\n", .{decision1_trim});

    std.debug.print("Is the 2nd input Yes or No? ", .{});
    var decision2: [5]u8 = undefined;
    _ = try stdin.readUntilDelimiter(&decision2, '\n');
    //    decision2 = std.mem.trim([5]u8, decision2, "\r");

    try stdout.print("{s}\n", .{decision1_trim});
    try stdout.print("{s}\n", .{decision2});
    //try stdout.print("Your inputs are: {s} and {s} and {s}\n", .{ decision1, decision2, decision2 });
}

fn perceptron(input1: f32, input2: f32, output: f32) void {

    // x = int(input())
    // y = int(input())
    // outputP = x*weights[0] + y*weights[1] + bias*weights[2]
    // if outputP > 0 : #activation function
    //    outputP = 1
    // else :
    //    outputP = 0
    // print(x, "or", y, "is : ", outputP)

    var outputP: f32 = input1 * weights[0] + input2 * weights[1] + bias * weights[2];

    const outputPError = output - outputP;
    std.debug.print("Unadjusted outputP: {d}\t; OPE: ,{d}\n", .{ outputP, outputPError });

    if (outputP > 0) {
        outputP = 1;
    } else {
        outputP = 0;
    }

    const outputError = output - outputP;

    weights[0] += outputError * input1 * learningRate;
    weights[1] += outputError * input2 * learningRate;
    weights[2] += outputError * bias * learningRate;
    std.debug.print("input1 : {d}\t input2: {d}\t output: {d}\n", .{ input1, input2, output });
    std.debug.print("Actual output: {d}\t\t outputerror: {d}\n", .{ outputP, outputError });
    std.debug.print("Weights: {d}\n", .{weights});

    weightSum = weights[0] + weights[1] + weights[2];
    std.debug.print("WeightSum: {d}\n\n", .{weightSum});
}
