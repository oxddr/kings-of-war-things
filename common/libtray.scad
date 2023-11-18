include <kow.scad>


module TrayFullMagnets(unit_type, unitSize) {
  Tray(unit_type, unitSize) {
    Grid(size = BaseNum(unit_type, unitSize), spacing = BaseSize(unit_type)) {
      Sockets(unit_type);
    }
  }
}

module Tray(unit_type, unitSize) {
  difference() {
    SimpleTray(unit_type, unitSize);
    children();
  }
}

// SimpleTray returns a tray of size for a given unit type and size.
// The tray is a simple square without any extra additions.
module SimpleTray(unit_type, unitSize) {
  baseSize = BaseSize(unit_type);
  baseNum = BaseNum(unit_type, unitSize);

  square(size = [ baseNum[0] * baseSize[0], baseNum[1] * baseSize[1] ]);
}

module Grid(size = [ 1, 1 ], spacing = [ 0, 0 ]) {
  for (i = [0:size[0] - 1], j = [0:size[1] - 1]) {
    translate([ i * spacing[0], j * spacing[1] ]) { children(0); }
  }
}

module MagnetHole() { Magnet(offset = -kerf); }

module Sockets(unit_type) {
  MagnetSockets(unit_type) { MagnetHole(); }
}