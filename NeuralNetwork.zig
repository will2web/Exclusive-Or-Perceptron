const std = @import("std");
const learningRate = 1;
var seed: u64 = undefined;

//Trying to move this array out of mainn
//var weights = [_]f32{ rand.float(f32), rand.float(f32), rand.float(f32) };

pub fn main() !void {
    //var seed: u64 = undefined;
    std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
        std.debug.print("Failed to get random seed: {}\n", .{err});
        return;
    };

    var prng = std.Random.DefaultPrng.init(seed);
    var rand = prng.random();

    const bias = 1;
    var weights = [_]f32{ rand.float(f32), rand.float(f32), rand.float(f32) };

    std.debug.print("\nMy Weights are: {d}\n", .{weights});

    var iterations: usize = 0;

    while (iterations < 50) {
        perceptron(&weights, bias, 1, 1, 1);
        perceptron(&weights, bias, 1, 0, 1);
        perceptron(&weights, bias, 0, 1, 1);
        perceptron(&weights, bias, 0, 0, 0);

        std.debug.print("This is iteration : {d}\n", .{iterations});
        std.debug.print("\nMy Weights are: {d}\n", .{weights});

        iterations += 1;
    }
}

fn perceptron(weights: *[3]f32, bias: comptime_int, input1: f32, input2: f32, output: f32) void {
    var outputP: f32 = input1 * weights[0] + input2 * weights[1] + bias * weights[2];

    if (outputP > 0) {
        outputP = 1;
    } else {
        outputP = 0;
    }

    //std.debug.print("outputP is {}\t", .{outputP});
    //  std.debug.print("output is {}\n", .{output});

    const outputError = output - outputP;
    //var outputerror: f32 = output - outputP;

    weights[0] += outputError * input1 * learningRate;
    weights[1] += outputError * input2 * learningRate;
    weights[2] += outputError * bias * learningRate;
    std.debug.print("outputP is {}\t", .{outputP});
    std.debug.print("output is {}\t", .{output});
    std.debug.print("outputerror is : {d}\n", .{outputError});
}
