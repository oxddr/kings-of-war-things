include <params.scad>;

module MagnetSockets(unit_type, only_diagonal = false) {
  baseSize = BaseSize(unit_type);

  translate([ 5, baseSize[1] - 5 ]) children();
  translate([ baseSize[0] - 5, 5 ]) children();

  if (!only_diagonal) {
    translate([ 5, 5 ]) children();
    translate([ baseSize[0] - 5, baseSize[1] - 5 ]) children();
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
                                                      : [ 10, 10 ];

function BaseNum(unit_type, unitSize) = unit_type == "infantry"
                                           ? unitSize == "horde" ? [ 10, 4 ]
                                             : unitSize == "regiment" ? [ 5, 4 ]
                                                                      : [ 5, 2 ]
                                       : unit_type == "cavalry"
                                           ? unitSize == "regiment" ? [ 5, 2 ]
                                                                    : [ 5, 1 ]
                                           : [ 1, 1 ];