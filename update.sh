#!/usr/bin/env bash
set -exuo pipefail
trap "rm -rf tmp" ERR

git clone https://github.com/michal-z/zig-gamedev --depth 1 tmp

rm -rf libs/ src/ build.zig
cp -r tmp/libs/zgui/libs .
cp -r tmp/libs/zgui/src .
cp tmp/libs/zgui/build.zig .

git checkout -- libs/imgui/imgui_impl_mach.cpp
git checkout -- src/zgui_mach.zig
mv src/main.zig src/zgui.zig
git checkout -- src/main.zig

echo -e "## NOTE\n
this is a fork of ["zgui"](https://github.com/michal-z/zig-gamedev/blob/main/libs/zgui) (dear imgui bindings) modified to support using `mach/gpu` (the WebGPU API for Zig) instead of `zgpu`. You can find examples in [mach-examples](https://github.com/hexops/mach-examples)
please don't create PRs for this repository\n" > README.md
cat tmp/libs/zgui/README.md >> README.md


rm -rf tmp
