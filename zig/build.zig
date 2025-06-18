const std = @import("std");
const Builder = std.Build;

pub fn build(b: *Builder) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .cpu_features_add = std.Target.wasm.featureSet(&.{.simd128}),
        .os_tag = .freestanding,
    });
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("./src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.root_module.addImport("zaw", b.dependency("zaw", .{
        .target = target,
        .optimize = optimize,
    }).module("zaw"));

    // <https://github.com/ziglang/zig/issues/8633>
    exe.global_base = 6560;
    exe.entry = .disabled;
    exe.rdynamic = true;
    exe.import_memory = true;
    exe.stack_size = std.wasm.page_size;

    b.installArtifact(exe);
}
