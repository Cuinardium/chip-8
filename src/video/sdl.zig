const std = @import("std");
const sdl = @cImport(@cInclude("SDL2/SDL.h"));
const process = std.process;

var window: ?*sdl.SDL_Window = null;
var renderer: ?*sdl.SDL_Renderer = null;
var texture: ?*sdl.SDL_Texture = null;

pub fn println(msg: []const u8) void {
    std.debug.print("{s}\n", .{msg});
}

pub fn createWindow() void {
    window = sdl.SDL_CreateWindow("chip-8", sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED, 1024, 512, 0);
    if (window == null) {
        @panic("Window Creation Failed!");
    }

    renderer = sdl.SDL_CreateRenderer(window, -1, 0);
    if (renderer == null) {
        const err = sdl.SDL_GetError();
        std.debug.print("{s}\n", .{err});
        @panic("Renderer Creation Failed!");
    }

    texture = sdl.SDL_CreateTexture(renderer, sdl.SDL_PIXELFORMAT_RGBA8888, sdl.SDL_TEXTUREACCESS_STREAMING, 64, 32);
    if (texture == null) {
        @panic("Texture Creation Failed!");
    }
}

pub fn destroyWindow() void {
    if (texture) |non_null_texture| sdl.SDL_DestroyTexture(non_null_texture);
    if (renderer) |non_null_renderer| sdl.SDL_DestroyRenderer(non_null_renderer);
    if (window) |non_null_window| sdl.SDL_DestroyWindow(non_null_window);

    texture = null;
    renderer = null;
    window = null;

    sdl.SDL_Quit();
}

pub fn render() void {
    //TODO
}

pub fn handleEvents() bool {
    var keep_open = true;
    var e: sdl.SDL_Event = undefined;
    while (sdl.SDL_PollEvent(&e) > 0) {
        switch (e.type) {
            sdl.SDL_QUIT => keep_open = false,
            sdl.SDL_KEYDOWN => {
                if (e.key.keysym.scancode == sdl.SDL_SCANCODE_ESCAPE) {
                    keep_open = false;
                }

                // TODO

            },
            sdl.SDL_KEYUP => {
                // TODO
            },
            else => {},
        }
    }
    return keep_open;
}
