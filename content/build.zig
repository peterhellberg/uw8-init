const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "uw8-cart",
        .root_source_file = b.path("src/main.zig"),
        .target = b.resolveTargetQuery(.{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        }),
        .optimize = .ReleaseSmall,
    });

    exe.entry = .disabled;
    exe.import_memory = true;
    exe.initial_memory = 262144;
    exe.max_memory = 262144;
    exe.global_base = 81920;
    exe.stack_size = 8192;

    exe.root_module.addImport("uw8", b.dependency("uw8", .{}).module("uw8"));

    exe.root_module.export_symbol_names = &[_][]const u8{
        "start",
        "snd",
        "upd",
    };

    b.installArtifact(exe);

    const run_filter_exports = b.addSystemCommand(&[_][]const u8{
        "uw8",
        "filter-exports",
        "zig-out/bin/uw8-cart.wasm",
        "zig-out/bin/uw8-cart-filtered.wasm",
    });
    run_filter_exports.step.dependOn(b.getInstallStep());

    const run_wasm_opt = b.addSystemCommand(&[_][]const u8{
        "wasm-opt",
        "-Oz",
        "-o",
        "zig-out/uw8-cart.wasm",
        "zig-out/bin/uw8-cart-filtered.wasm",
    });
    run_wasm_opt.step.dependOn(&run_filter_exports.step);

    const run_uw8_pack = b.addSystemCommand(&[_][]const u8{
        "uw8",
        "pack",
        "-l",
        "9",
        "zig-out/uw8-cart.wasm",
        "zig-out/uw8-cart.uw8",
    });
    run_uw8_pack.step.dependOn(&run_wasm_opt.step);

    const make_opt = b.step("make_opt", "make size optimized cart");
    make_opt.dependOn(&run_uw8_pack.step);

    b.default_step = make_opt;

    const run_cmd = b.addSystemCommand(&[_][]const u8{
        "uw8",
        "run",
        "--watch",
        "--no-gpu",
        "zig-out/uw8-cart.uw8",
    });
    run_cmd.step.dependOn(make_opt);

    const run_step = b.step("run", "Run the MicroW8 cart");
    run_step.dependOn(&run_cmd.step);

    const spy_cmd = b.addSystemCommand(&[_][]const u8{
        "spy",
        "--exc",
        ".zig-cache",
        "--inc",
        "**/*.zig",
        "-q",
        "clear-zig",
        "build",
    });
    const spy_step = b.step("spy", "Run spy watching for file changes");
    spy_step.dependOn(&spy_cmd.step);
}
