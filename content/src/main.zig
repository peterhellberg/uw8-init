const uw8 = @import("uw8");

export fn start() void {
    uw8.PALETTE[0x0] = 0x282223;
    uw8.PALETTE[0x1] = 0x614228;
    uw8.PALETTE[0x2] = 0x54585f;
    uw8.PALETTE[0x3] = 0x738587;
    uw8.PALETTE[0x4] = 0x95b0b8;
    uw8.PALETTE[0x5] = 0xc7d5c3;
    uw8.PALETTE[0x6] = 0xdceceb;
    uw8.PALETTE[0x7] = 0xa68524;
    uw8.PALETTE[0x8] = 0xd2ba54;
    uw8.PALETTE[0x9] = 0x454d75;
    uw8.PALETTE[0xA] = 0x4650c6;
    uw8.PALETTE[0xB] = 0x8a92e6;
    uw8.PALETTE[0xC] = 0x53741e;
    uw8.PALETTE[0xD] = 0x58a055;
    uw8.PALETTE[0xE] = 0x41bfa1;
    uw8.PALETTE[0xF] = 0x54c0e3;
}

var x: f32 = 160;
var y: f32 = 120;

export fn upd() void {
    uw8.cls(4);

    if (uw8.isButtonPressed(uw8.BUTTON_UP)) y -= 0.5;
    if (uw8.isButtonPressed(uw8.BUTTON_DOWN)) y += 0.5;
    if (uw8.isButtonPressed(uw8.BUTTON_LEFT)) x -= 0.5;
    if (uw8.isButtonPressed(uw8.BUTTON_RIGHT)) x += 0.5;

    for (0..16) |i| {
        uw8.rectangle(@floatFromInt(20 * i), 0, 20, 240, @intCast(i));
    }

    uw8.setTextColor(0x1);
    uw8.setBackgroundColor(0x6);

    uw8.setTextScale(2);
    uw8.swapTextBackgroundColors();

    uw8.setCursorPosition(1, 1);

    uw8.circle(x, y, 40, 0);

    uw8.printString("Hello: ");
    uw8.printInt(uw8.TIME_MS.*);
}

export fn snd(sampleIndex: i32) f32 {
    _ = sampleIndex; // autofix
    return 0;
}
