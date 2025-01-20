pub const VideoInterface = struct {
    createWindow: fn () void,
    destroyWindow: fn () void,
    render: fn () void,
    handleEvents: fn () bool,
};
