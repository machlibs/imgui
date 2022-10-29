# mach/imgui - dear imgui bindings for [Mach engine](https://machengine.org)

This repository contains community-maintained Dear Imgui bindings for [Mach engine](https://machengine.org). Works on Windows, Linux, and macOS with zero-fuss cross-compilation & more.

<img height="300px" src="https://user-images.githubusercontent.com/3173176/198845698-4969dcdf-32ef-4cf0-968c-88ffd5a7cff1.png"></img>
<img height="300px" src="https://user-images.githubusercontent.com/3173176/198846123-b9f55d0d-af4f-4770-ab73-88546f1e458b.png"></img>

### Running the example

```sh
git clone --recursive https://github.com/machlibs/imgui
cd imgui/
zig build run-example-basic
```

### Usage

First [create a Mach engine project](https://github.com/hexops/mach-examples#use-mach-engine-in-your-own-project), then in a `libs` subdirectory of your repo root add the dependency:

```sh
git clone --recursive https://github.com/machlibs/imgui
```

Then in your `build.zig` add:

```zig
...
const imgui = @import("libs/imgui/build.zig");

pub fn build(b: *Builder) void {
    ...
    exe.addPackage(imgui.getPkg(&[_]std.build.Pkg{}));
    imgui.link(b, exe, .{});
}
```

## Join the community

Join the Mach community [on Discord](https://discord.gg/XNG3NZgCqp) or [Matrix](https://matrix.to/#/#hexops:matrix.org) to discuss this project, ask questions, get help, etc.


## Discription of files

* imgui_c_keys.h - c header file with Imgui keys enum is used to map mach keys to imgui keys.
* zgui_mach.zig - mach backend implementation for zgui
* main.zig - main file that provides backend and imgui bindings (copied from zgui)
* zgui.cpp and zgui.zig - imgui cpp bindings to zig functions (copied from zgui)

## Credits

* Based on michal-z's [zgui](https://github.com/michal-z/zig-gamedev/tree/main/libs/zgui)
* Mach integration originally by @SergeiSomin
