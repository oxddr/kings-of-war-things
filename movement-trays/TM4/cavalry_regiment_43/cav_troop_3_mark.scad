use <common/libtray.scad>;

$fn = $preview ? 32 : 64;

translate([ 20, 0 ]) Grid(size = [ 3, 1 ], spacing = [ 30, 0 ]) {
  Base("cavalry");
}