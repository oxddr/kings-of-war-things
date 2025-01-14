include <common/libtray.scad>
use <common/kow.scad>

unitType = "infantry";
unitSize = "troop";

union() {
  linear_extrude(height = base_height) {
    Tray(unitType, unitSize) {
      DiagonalGrid(unitType, unitSize, gridSize = [4, 2], noMargin = true) {
        BM4Sockets(unitType, spacing = magnet_spacing);
      }
    }

  }
  translate([0, 0, base_height])
    linear_extrude(height = base_height) {
      Tray(unitType, unitSize) {
        DiagonalGrid(unitType, unitSize, gridSize = [4, 2], noMargin = true) {
          translate(margin * -0.5)
            Base(unitType, extraMargin = margin);
        }
      }
    }
}
