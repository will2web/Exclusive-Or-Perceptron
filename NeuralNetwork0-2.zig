const std = @import("std");
var seed: u64 = undefined;
var rand = prng.random();
var prng = std.Random.DefaultPrng.init(seed);
const weight1 = rand.float(f32);
const weight2 = rand.float(f32);
const weight3 = rand.float(f32);
const learningRate = 1;
const bias = 1;

const weights = [_]f32{ weight1, weight2, weight3 };

pub fn main() !void {
    std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
        std.debug.print("Failed to get random seed: {}\n", .{err});
        return;
    };

    std.debug.print("Seed address is: {}\n", .{&seed});

    var x: i3 = undefined;
    x = learningRate + bias;

    std.debug.print("Learning Rate plus Bias Equals {d}\n", .{x});
    std.debug.print("Weight 1 is : {d}\n", .{weight1});
    std.debug.print("Weight 2 is : {d}\n", .{weight2});
    std.debug.print("Weight 3 is : {d}\n", .{weight3});

    std.debug.print("len: {}\n", .{weights.len});
    std.debug.print("\nMy Weights are: {any}\n", .{weights});
}

// fn perceptron(input1: f32, input2: f32, output: f32) void {
//     const outputP: f32 = input1 * weights[0];
// }

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
