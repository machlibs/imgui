# mach/imgui - dear imgui bindings for Mach

This repository contains community-maintained [Dear Imgui](https://github.com/ocornut/imgui) bindings for the [Mach engine](https://machengine.org).

This project is designed to integrate into an existing mach-based application. You can read [here](https://github.com/hexops/mach-examples#use-mach-engine-in-your-own-project) to learn how to create one.

<img height="300px" src="https://user-images.githubusercontent.com/3173176/198845698-4969dcdf-32ef-4cf0-968c-88ffd5a7cff1.png"></img>
<img height="300px" src="https://user-images.githubusercontent.com/3173176/198846123-b9f55d0d-af4f-4770-ab73-88546f1e458b.png"></img>


## Project setup / integration

### 1. Add submodule

```sh
git clone https://github.com/machlibs/imgui libs/imgui
```

### 2. Integrate into build.zig

```zig
...
const imgui = @import("libs/imgui/build.zig");

pub fn build(b: *Builder) void {
    ...
    exe.addPackage(imgui.getPkg(&[_]std.build.Pkg{}));
    imgui.link(exe);
}
```

### 3. Import & use

Mach/imgui depends on [mach](https://github.com/hexops/mach). This dependency is satisfied using a comptime injection instead of a redundant mach submodule. As a result, to gain access to the imgui interface you need construct the ```MachImgui``` type by passing the mach module.

```zig
    const std = @import("std");
    const mach_imgui = @import("mach-imgui");
    const mach = @import("mach");

    const imgui = mach_imgui.MachImgui(mach);
```

This exposes the dear imgui interface under the ```imgui``` namespace, which you can use as shown below.

```zig
    pub fn init(app: *App, core: *mach.Core) !void {
        imgui.init();

        const font_size = 18.0;
        const font_normal = imgui.io.addFontFromFile(
            "assets/font/Roboto-Medium.ttf", 
            font_size
        );

        imgui.backend.init(core.device, core.swap_chain_format, null);
        imgui.io.setDefaultFont(font_normal);

        const style = imgui.getStyle();
        style.window_min_size = .{ 100.0, 100.0 };
        style.window_border_size = 8.0;
        style.scrollbar_size = 6.0;
    }

    pub fn deinit(_: *App, _: *mach.Core) void {
        imgui.backend.deinit();
    }

    pub fn update(app: *App, core: *mach.Core) !void {
        if (core.hasEvent()) {
            const input_event: mach.Event = core.pollEvent().?;
            //
            // Passing Mach event to Imgui
            //
            imgui.backend.passEvent(input_event);
        }
        ...
    }

```

**NOTE**: Backend related events (Such as init, draw and passEvent) are further namespaced under imgui.backend.

## Join the community

Join the Mach community [on Discord](https://discord.gg/XNG3NZgCqp) or [Matrix](https://matrix.to/#/#hexops:matrix.org) to discuss this project, ask questions, get help, etc.


## Description of files

* imgui_c_keys.h - c header file with Imgui keys enum is used to map mach keys to imgui keys.
* zgui_mach.zig - mach backend implementation for zgui
* main.zig - main file that provides backend and imgui bindings (copied from zgui)
* zgui.cpp and zgui.zig - imgui cpp bindings to zig functions (copied from zgui)

## Credits

* Based on michal-z's [zgui](https://github.com/michal-z/zig-gamedev/tree/main/libs/zgui)
* Mach integration originally by @SergeiSomin
