# uw8-init :sparkles:

This is a command line tool that acts as a companion to my
[uw8](https://github.com/peterhellberg/uw8) module
for [Zig](https://ziglang.org/) :zap:

`uw8-init` is used to create a directory containing code that
allows you to promptly get started coding on a cart for the
lovely little fantasy console [MicroW8](https://exoticorn.github.io/microw8/).

The Zig build `.target` is declared as `.{ .cpu_arch = .wasm32, .os_tag = .freestanding }`
and `.optimize` is set to `.ReleaseSmall`

> [!Important]
> No need to specify `-Doptimize=ReleaseSmall`

## Installation

(Requires you to have [Go](https://go.dev/) installed)

```sh
go install github.com/peterhellberg/w4-init@latest
```

## Usage

(Requires you to have an up to date (_nightly_) version of
[Zig](https://ziglang.org/download/#release-master) installed.

```sh
uw8-init mycart
cd mycart
zig build run
```

:seedling:
