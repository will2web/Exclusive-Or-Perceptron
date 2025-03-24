const std = @import("std");
//const RandomNumGenerate = std.rand.DefaultPrng.init(42);

pub fn main() !void {
    var seed: u64 = undefined;
    std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
        std.debug.print("Failed to get random seed: {}\n", .{err});
        return;
    };

    std.debug.print("Seed address is: {}\n", .{&seed});

    var prng = std.Random.DefaultPrng.init(seed);
    var rand = prng.random();

    const weight1 = rand.float(f32);
    const weight2 = rand.float(f32);
    const weight3 = rand.float(f32);
    const learningRate = 1;
    const bias = 1;
    const weights = [_]f32{ weight1, weight2, weight3 };

    std.debug.print("Data type for bias is {}\n", .{@TypeOf(bias)});

    var x: i3 = undefined;
    x = learningRate + bias;

    std.debug.print("Learning Rate plus Bias Equals {d}\n", .{x});
    std.debug.print("Weight 1 is : {d}\n", .{weight1});
    std.debug.print("Weight 2 is : {d}\n", .{weight2});
    std.debug.print("Weight 3 is : {d}\n", .{weight3});

    std.debug.print("len: {}\n", .{weights.len});
    std.debug.print("\nMy Weights are: {any}\n", .{weights});

    perceptron(weights, bias, 3, 4, 5);
}

fn perceptron(weights: [3]f32, bias: comptime_int, input1: f32, input2: f32, output: f32) void {
    var outputP: f32 = input1 * weights[0] + input2 * weights[1] + bias * weights[2];

    if (outputP > 0) {
        outputP = 1;
        std.debug.print("outputP is {}\n", .{outputP});
    } else {
        outputP = 0;
        std.debug.print("outputP is {}\n", .{outputP});
    }

    std.debug.print("outputP is {}\n", .{outputP});
    std.debug.print("output is {}\n", .{output});
}

// def Perceptron(input1, input2, output) :
//    outputP = input1*weights[0]+input2*weights[1]+bias*weights[2]
//    if outputP > 0 : #activation function (here Heaviside)
//       outputP = 1
//    else :
//       outputP = 0
//    error = output – outputP
//    weights[0] += error * input1 * lr
//    weights[1] += error * input2 * lr
//    weights[2] += error * bias * lr
