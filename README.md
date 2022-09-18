# mach/foobar - a project template

## Getting started

### Adding dependency

In a `libs` subdirectory of the root of your project:

```sh
git clone https://github.com/machlibs/foobar
```

Then in your `build.zig` add:

```zig
...
const foobar = @import("libs/foobar/build.zig");

pub fn build(b: *Builder) void {
    ...
    exe.addPackage(foobar.pkg);
    foobar.link(b, exe, .{});
}
```

## Join the community

Join the Mach community [on Discord](https://discord.gg/XNG3NZgCqp) or [Matrix](https://matrix.to/#/#hexops:matrix.org) to discuss this project, ask questions, get help, etc.
