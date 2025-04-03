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

    std.debug.print("Please type Yes or NO for 1st Decision", .{});

    //     while (true) {
    //         const stdin = std.io.getStdIn().reader();
    //         const stdout = std.io.getStdOut().writer();
    //         const bare_line = try stdin.readUntilDelimiterAlloc(
    //             std.heap.page_allocator,
    //             '\n',
    //             8192,
    //         );
    //         defer std.heap.page_allocator.free(bare_line);
    // const line = std.mem.trim(u8, bare_line, "\r");

    var input: [5]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    _ = try stdin.readUntilDelimiter(&input, '\n');

    try stdout.print("The user entered: {s}\n", .{input});

    // const stdin = std.io.getStdIn().reader();
    // var buf: [10]u8 = undefined;
    // var decision1: []u8 = undefined;

    // if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
    //     decision1 = user_input; //std.fmt.parseInt(i64, user_input, 10);
    // } else {
    //     decision1 = undefined;
    // }

    //   std.debug.print("You have selected {any}", .{decision1});

    //perceptron(input1: f32, input2: f32, output: f32)
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
