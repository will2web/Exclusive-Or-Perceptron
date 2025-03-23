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

    var x: i3 = undefined;
    x = learningRate + bias;

    std.debug.print("Learning Rate plus Bias Equals {d}\n", .{x});
    std.debug.print("Weight 1 is : {d}\n", .{weight1});
    std.debug.print("Weight 2 is : {d}\n", .{weight2});
    std.debug.print("Weight 3 is : {d}\n", .{weight3});

    std.debug.print("len: {}\n", .{weights.len});
    std.debug.print("\nMy Weights are: {any}\n", .{weights});
}
