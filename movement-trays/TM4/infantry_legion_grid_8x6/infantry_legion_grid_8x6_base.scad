include <common/libtray.scad>;
use <common/kow.scad>;

unitType = "infantry";
unitSize = "legion";

Tray(unitType, unitSize) {
  AdjustingGrid(unitType, unitSize, gridSize = [ 8, 5 ]) { Sockets("infantry"); }
}