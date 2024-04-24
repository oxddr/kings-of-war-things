include <common/libtray.scad>;
use <common/kow.scad>;

unitType = "cavalry";
unitSize = "regiment";

Tray(unitType, unitSize) {
  DiagonalGrid(unitType, unitSize, gridSize = [ 4, 2 ]) {
    BM4Sockets(unitType, spacing = -kerf);
  }
}