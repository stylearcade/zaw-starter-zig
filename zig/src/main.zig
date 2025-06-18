const zaw = @import("zaw");
const interop = zaw.interop;
const simd = zaw.simd;
const OK = interop.OK;

const Vec = simd.Vec;

comptime {
    zaw.setupInterop();
}

export fn xorInt32Array() i32 {
    var input = interop.getInput();
    var output = interop.getOutput();

    const values = input.readArray(i32);
    const len = values.len;
    const lanes = simd.getLanes(i32);
    const batchSize = lanes * 4;

    var acc: [4]Vec(i32) = .{
        simd.initVec(i32),
        simd.initVec(i32),
        simd.initVec(i32),
        simd.initVec(i32),
    };
    var i: usize = 0;

    while (i + batchSize <= len) : (i += batchSize) {
        const offset = values[i..];

        acc[0] ^= simd.sliceToVec(i32, offset);
        acc[1] ^= simd.sliceToVec(i32, offset[lanes..]);
        acc[2] ^= simd.sliceToVec(i32, offset[lanes * 2 ..]);
        acc[3] ^= simd.sliceToVec(i32, offset[lanes * 3 ..]);
    }

    while (i + lanes <= len) : (i += lanes) {
        acc[0] ^= simd.sliceToVec(i32, values[i..]);
    }

    var total: i32 = 0;

    for (0..lanes) |x| total ^= acc[0][x] ^ acc[1][x] ^ acc[2][x] ^ acc[3][x];

    if (i < len) {
        for (values[i..len]) |x| total ^= x;
    }

    output.write(i32, total);

    return OK;
}
