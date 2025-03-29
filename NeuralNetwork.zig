const std = @import("std");
const learningRate = 1;

pub fn main() !void {
    var seed: u64 = undefined;
    std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
        std.debug.print("Failed to get random seed: {}\n", .{err});
        return;
    };

    var prng = std.Random.DefaultPrng.init(seed);
    var rand = prng.random();

    const weight1 = rand.float(f32);
    const weight2 = rand.float(f32);
    const weight3 = rand.float(f32);

    const bias = 1;
    var weights = [_]f32{ weight1, weight2, weight3 };

    // std.debug.print("Weight 1 is : {d}\n", .{weight1});
    // std.debug.print("Weight 2 is : {d}\n", .{weight2});
    // std.debug.print("Weight 3 is : {d}\n", .{weight3});

    std.debug.print("\nMy Weights are: {d}\n", .{weights});

    var iterations: usize = 0;

    while (iterations < 50) {
        perceptron(&weights, bias, 1, 1, 1);
        perceptron(&weights, bias, 1, 0, 1);
        perceptron(&weights, bias, 0, 1, 1);
        perceptron(&weights, bias, 0, 0, 0);

        std.debug.print("This is iteration : {d}\n", .{iterations});
        std.debug.print("Weight 1 is : {d}|", .{weights[0]});
        std.debug.print("Weight 2 is : {d}|", .{weights[1]});
        std.debug.print("Weight 3 is : {d}\n", .{weights[2]});

        iterations += 1;
    }
}

fn perceptron(weights: *[3]f32, bias: comptime_int, input1: f32, input2: f32, output: f32) void {
    var outputP: f32 = input1 * weights[0] + input2 * weights[1] + bias * weights[2];

    // print(x, "or", y, "is : ", outputP)

    if (outputP > 0) {
        outputP = 1;
        //std.debug.print("outputP is {}\t", .{outputP});
    } else {
        outputP = 0;
        //std.debug.print("outputP is {}\n", .{outputP});
    }

    //std.debug.print("outputP is {}\t", .{outputP});
    //  std.debug.print("output is {}\n", .{output});

    const outputError = output - outputP;
    //var outputerror: f32 = output - outputP;

    std.debug.print("outputerror is : {d}\n", .{outputerror});
    weights[0] += outputerror * input1 * learningRate;
    weights[1] += outputerror * input2 * learningRate;
    weights[2] += outputerror * bias * learningRate;
    std.debug.print("outputP is {}\t", .{outputP});
    std.debug.print("output is {}\t", .{output});
    // std.debug.print("Weight 1 is : {d}\n", .{weights[0]});
    // std.debug.print("Weight 2 is : {d}\n", .{weights[1]});
    // std.debug.print("Weight 3 is : {d}\n", .{weights[2]});
}
