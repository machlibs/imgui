# mach/imgui - imgui bindings for mach engine

## Getting started

### Adding dependency

In a `libs` subdirectory of the root of your project:

```sh
git clone https://github.com/machlibs/imgui
```

Then in your `build.zig` add:

```zig
...
const imgui = @import("libs/imgui/build.zig");

pub fn build(b: *Builder) void {
    ...
    exe.addPackage(imgui.pkg);
    imgui.link(b, exe, .{});
}
```

## Join the community

Join the Mach community [on Discord](https://discord.gg/XNG3NZgCqp) or [Matrix](https://matrix.to/#/#hexops:matrix.org) to discuss this project, ask questions, get help, etc.


## Credit
Based on michal-z zgui library: https://github.com/michal-z/zig-gamedev/tree/main/libs/zgui