include <common/libtray.scad>;
use <common/kow.scad>;

unitType = "infantry";
unitSize = "horde";

Tray(unitType, unitSize) {
  AdjustingGrid(unitType, unitSize, gridSize = [ 8, 3 ]) {
    BM4Sockets("infantry", spacing = -kerf);
  }
}