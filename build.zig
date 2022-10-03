const std = @import("std");
const Pkg = std.build.Pkg;

pub fn getPkg(dependencies: []const Pkg) Pkg {
    return .{
        .name = "mach-imgui",
        .source = .{ .path = thisDir() ++ "/src/main.zig" },
        .dependencies = dependencies,
    };
}

pub fn link(exe: *std.build.LibExeObjStep) void {
    exe.addCSourceFile(thisDir() ++ "/src/zgui.cpp", &.{""});
    exe.addIncludePath(thisDir() ++ "/libs");
	exe.addIncludeDir(thisDir() ++ "/libs");

    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_impl_wgpu.cpp", &.{""});
	exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_impl_mach.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/implot_demo.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/implot.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/implot_items.cpp", &.{""});
}

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}


pub fn build(b: *std.build.Builder) !void {

	const target = b.standardTargetOptions(.{});
	const mode = b.standardReleaseOptions();

	const name = "example-basic";
	const mach = @import("libs/mach/build.zig");

	const mach_imgui_pkg = getPkg(&[_]Pkg{mach.pkg});

	const example_app = try mach.App.init(
		b,
		.{
			.name = name,
			.src = "./examples/basic/main.zig",
			.target = target,
			.deps = &[_]Pkg{mach_imgui_pkg},
		},
	);

	example_app.setBuildMode(mode);
	try example_app.link(.{});
	link(example_app.step);

	const compile_step = b.step("compile-" ++ name, "Compile " ++ name);
	compile_step.dependOn(&b.addInstallArtifact(example_app.step).step);
	b.getInstallStep().dependOn(compile_step);

	const run_cmd = try example_app.run();
	run_cmd.dependOn(compile_step);

	const run_step = b.step("run-" ++ name, "Run " ++ name);
	run_step.dependOn(run_cmd);

	const test_step = b.step("test", "Test");
	test_step.dependOn(compile_step);
}