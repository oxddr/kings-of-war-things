include <common/libtray.scad>;
use <common/kow.scad>;

unitType = "lrgcav";
unitSize = "horde";

Tray(unitType, unitSize) {
  DiagonalGrid(unitType, unitSize, gridSize = [ 3, 2 ]) {
    BM4Sockets(unitType, spacing = -kerf);
  }
}