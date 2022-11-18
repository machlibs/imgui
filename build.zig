const std = @import("std");
const Pkg = std.build.Pkg;

const this_dir = thisDir();

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}

pub fn getPkg(dependencies: []const Pkg) Pkg {
    return .{
        .name = "mach-imgui",
        .source = .{ .path = this_dir ++ "/src/main.zig" },
        .dependencies = dependencies,
    };
}

pub fn link(exe: *std.build.LibExeObjStep) void {
    exe.defineCMacro("IMGUI_IMPL_API", "extern \"C\"");

    exe.addIncludePath(this_dir ++ "/src");
    exe.addIncludePath(this_dir ++ "/libs");
    exe.addIncludePath(this_dir ++ "/libs/imgui");

    exe.addCSourceFile(this_dir ++ "/src/zgui.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui_impl_wgpu.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/imgui_impl_mach.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/implot_demo.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/implot.cpp", &.{""});
    exe.addCSourceFile(this_dir ++ "/libs/imgui/implot_items.cpp", &.{""});

    exe.linkLibCpp();
}

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const tests = b.addTest(this_dir ++ "/src/main.zig");
    tests.setBuildMode(mode);
    tests.setTarget(target);

    const test_step = b.step("test", "Run mach-imgui tests");
    test_step.dependOn(&tests.step);
}
