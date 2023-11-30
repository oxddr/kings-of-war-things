include <common/kow.scad>;

module MagnetHole() { Magnet(offset = magnet_spacing); } 

module BaseBM4(unit_type, only_diagonal = false) {
  linear_extrude(height = base_height) {
    difference() {
      Base(unit_type = unit_type);
      union() {
        MagnetSockets(unit_type = unit_type, only_diagonal = only_diagonal) {
          MagnetHole();
        }
        children();
      }
    }
  }
}

SLOTTA_ANGLE = 0;
SLOTTA_SLOT_MARGIN = 1.5; 

module SlottaBM4(a = SLOTTA_ANGLE, unit_type = "infantry", slot_margin = SLOTTA_SLOT_MARGIN) {
  slot_width = 1.9;  // or 1.8
  base_size = BaseSize(unit_type);

  // slot_length = 18; for a = 0 (as in GW bases)
  // total_slot_margin = 4; for a = 45 (as in GW bases)

  slot_length =
      (base_size[0] - 2 * slot_margin - cos(90 - a) * slot_width) / cos(a);

  BaseBM4(unit_type = unit_type, only_diagonal = true) {
    translate(0.5 * base_size) rotate(a)
        square([ slot_length, slot_width ], center = true);
  };
}

module CavalrySlot() {
  slotWidth = 2.5;
  slotLength = 35;
  slotSpacing = 2.8;
  baseSize = BaseSize("cavalry");

  translate([
    (baseSize[0] - 2 * slotWidth - slotSpacing) / 2,
    (baseSize[1] - slotLength) / 2
  ]) {
    square([ slotWidth, slotLength ]);
    translate([ slotSpacing + slotWidth, 0 ]) square([ slotWidth, slotLength ]);
  }
}