include <common/libtray.scad>;

Tray(unit_type = "cavalry", unitSize = "regiment") {
  union() {
    translate([ 5, 0 ]) Grid(size = [ 4, 1 ], spacing = [ 30, 0 ]) {
      Sockets("cavalry");
    }
    translate([ 20, 50 ]) Grid(size = [ 3, 1 ], spacing = [ 30, 0 ]) {
      Sockets("cavalry");
    }
  }
}