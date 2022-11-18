pub fn MachImgui(comptime mach: anytype) type {
    return struct {
        pub usingnamespace @import("zgui.zig");
        pub const backend = @import("zgui_mach.zig").MachBackend(mach);
    };
}
