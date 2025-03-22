const std = @import("std");
//const RandomNumGenerate = std.rand.DefaultPrng.init(42);

pub fn main() !void {
    var seed: u64 = undefined;
    std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
        std.debug.print("Failed to get random seed: {}\n", .{err});
        return;
    };

    var prng = std.Random.DefaultPrng.init(seed);
    var rand = prng.random();

    //below just for testing/debuging random number generator
    // Generate a random float between 0 and 1
    //const value = rand.float(f32);
    //std.debug.print("Random value: {}\n", .{value});
    //std.debug.print("My random number is: {d}\n", .{value});

    const weight1 = rand.float(f32);
    const weight2 = rand.float(f32);
    const weight3 = rand.float(f32);
    const learningRate = 1;
    const bias = 1;

    var x: i3 = undefined;
    x = learningRate + bias;

    std.debug.print("Learning Rate plus Bias Equals {d}\n", .{x});
    std.debug.print("Weight 1 is : {d}\n", .{weight1});
    std.debug.print("Weight 2 is : {d}\n", .{weight2});
    std.debug.print("Weight 3 is : {d}\n", .{weight3});
}
