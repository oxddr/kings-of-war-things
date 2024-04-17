include <common/libtray.scad>;


Tray(unit_type = "cavalry", unitSize = "troop") {
  translate([ 5, 0 ]) Grid(size = [ 4, 1 ], spacing = [ 30, 0 ]) {
    BM4Sockets("cavalry", spacing = -kerf);
  }
}