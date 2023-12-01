use <common/kow.scad>;
use <common/libtray.scad>;

linear_extrude(height = 3) {
  Tray(unit_type = "cavalry", unitSize = "regiment") {
    union() {
      translate([ 5, 0 ]) Grid(size = [ 4, 1 ], spacing = [ 30, 0 ]) {
        Base("cavalry", extraMargin = [ 0.2, 0.2 ]);
      }
      translate([ 20, 50 ]) Grid(size = [ 3, 1 ], spacing = [ 30, 0 ]) {
        Base("cavalry", extraMargin = [ 0.2, 0.2 ]);
      }
    }
  }
}