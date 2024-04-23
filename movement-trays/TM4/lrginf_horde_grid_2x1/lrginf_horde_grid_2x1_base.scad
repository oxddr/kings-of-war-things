include <common/libtray.scad>;
use <common/kow.scad>;

unitType = "lrginf";
unitSize = "horde";

Tray(unitType, unitSize) {
  AdjustingGrid(unitType, unitSize, gridSize = [ 2, 1 ]) {
    BM4Sockets(unitType, spacing = -kerf);
  }
}