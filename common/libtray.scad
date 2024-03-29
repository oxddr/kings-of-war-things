include <kow.scad>

margin = [ 0.5, 0.5 ];

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

// AdjustingGrid returns a grid of elements. 
// The margins between elements are calculated to be equal and fill the tray.
module AdjustingGrid(unitType, unitSize, gridSize = [ 1, 1 ], margin = margin) {
  base_num = BaseNum(unitType, unitSize);
  base_size = BaseSize(unitType);

  tm = [
    ((base_num[0] * base_size[0]) -
     (gridSize[0] * (base_size[0] + margin[0]))) /
        (gridSize[0] + 1),
    ((base_num[1] * base_size[1]) -
     (gridSize[1] * (base_size[1] + margin[1]))) /
        (gridSize[1] + 1),
  ];

  total_spacing = base_size + tm + margin;

  translate(tm) Grid(size = gridSize, spacing = total_spacing) { children(0); }
}

module TrayGrid(unitType, unitSize, gridSize = [ 1, 1 ]) {
  union() {
    Tray(unit_type = unitType, unitSize = unitSize) {
      AdjustingGrid(unitType, unitSize, gridSize) {
        Base(unitType, extraMargin = margin);
      }
    }
    AdjustingGrid(unitType, unitSize, gridSize) { 
      translate(margin / 2) Base(unitType); }
  }
}

module MagnetHole() { Magnet(offset = -kerf); }

module Sockets(unit_type) {
  MagnetSockets(unit_type) { MagnetHole(); }
}