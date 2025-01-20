const std = @import("std");
const sdl = @cImport(@cInclude("SDL2/SDL.h"));
const process = std.process;

pub fn println(msg: []const u8) void {
    std.debug.print("{s}\n", .{msg});
}

pub const SDLVideo = struct {
    window: ?*sdl.SDL_Window = null,
    renderer: ?*sdl.SDL_Renderer = null,
    texture: ?*sdl.SDL_Texture = null,

    pub fn createWindow(self: *SDLVideo) void {
        self.window = sdl.SDL_CreateWindow("chip-8", sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED, 1024, 512, 0);
        if (self.window == null) {
            @panic("SDL Window Creation Failed!");
        }

        self.renderer = sdl.SDL_CreateRenderer(self.window, -1, 0);
        if (self.renderer == null) {
            const err = sdl.SDL_GetError();
            std.debug.print("{s}\n", .{err});
            @panic("SDL Renderer Initialization Failed!");
        }

        self.texture = sdl.SDL_CreateTexture(self.renderer, sdl.SDL_PIXELFORMAT_RGBA8888, sdl.SDL_TEXTUREACCESS_STREAMING, 64, 32);
        if (self.texture == null) {
            @panic("SDL Texture Creation Failed!");
        }
    }

    pub fn destroyWindow(self: *SDLVideo) void {
        if (self.texture) |texture| sdl.SDL_DestroyTexture(texture);
        if (self.renderer) |renderer| sdl.SDL_DestroyRenderer(renderer);
        if (self.window) |window| sdl.SDL_DestroyWindow(window);

        self.texture = null;
        self.renderer = null;
        self.window = null;

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
};
