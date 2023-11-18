include <common/libtray.scad>;

$fn = $preview ? 32 : 64;

Tray(unit_type = "cavalry", unitSize = "troop") {
  translate([ 5, 0 ]) Grid(size = [ 4, 1 ], spacing = [ 30, 0 ]) {
    Sockets("cavalry");
  }
}