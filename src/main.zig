const std = @import("std");
const video = @import("./video/sdl.zig");

// 60 hz => 1 loop per 16 ms?
const SLEEP_WAIT = 16 * 1000 * 1000;

pub fn main() !void {

    // Initialize video
    video.createWindow();
    defer video.destroyWindow();

    // Cycle
    var cycle = true;
    while (cycle) {

        // TODO: cpu cycle
        // cpu.cycle()

        cycle = video.handleEvents();

        video.render();

        // sleep
        std.time.sleep(SLEEP_WAIT);
    }
}
