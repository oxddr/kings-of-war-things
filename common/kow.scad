include <params.scad>;

module MagnetSockets(unit_type, only_diagonal = false) {
  baseSize = BaseSize(unit_type);

  translate([ 5, baseSize[1] - 5 ]) children(0);
  translate([ baseSize[0] - 5, 5 ]) children(0);

  if (!only_diagonal) {
    translate([ 5, 5 ]) children(0);
    translate([ baseSize[0] - 5, baseSize[1] - 5 ]) children(0);
  }
}

module Magnet(d = default_magnet_diameter, offset = 0) {
  circle(d = d + offset);
}

module Base(unit_type, extraMargin = [ 0, 0 ]) {
  square(BaseSize(unit_type) + extraMargin);
}

function BaseSize(unit_type) = unit_type == "infantry"  ? [ 20, 20 ]
                               : unit_type == "cavalry" ? [ 25, 50 ]
                               : unit_type == "lrginf"  ? [ 40, 40 ]
                               : unit_type == "lrgcav"  ? [ 50, 50 ]
                               : unit_type == "titan"   ? [ 75, 75 ]
                                                        : [ 10, 10 ];

function BaseNum(unit_type, unitSize) =
    unit_type == "infantry"  ? unitSize == "legion"     ? [ 10, 6 ]
                                   : unitSize == "horde"    ? [ 10, 4 ]
                                   : unitSize == "regiment" ? [ 5, 4 ]
                                                            : [ 5, 2 ]
    : unit_type == "cavalry" ? unitSize == "regiment" ? [ 5, 2 ] : [ 5, 1 ]
    : unit_type == "lrginf"  ? unitSize == "regiment" ? [ 3, 2 ] : [ 3, 1 ]
    : unit_type == "lrgcav"  ? unitSize == "regiment" ? [ 3, 1 ] : [ 1, 1 ]
                                 : [ 1, 1 ];