include <common/libtray.scad>;

$fn = $preview ? 32 : 64;

translate([ 5, 0 ]) Grid(size = [ 4, 1 ], spacing = [ 30, 0 ]) {
  Base("cavalry");
}