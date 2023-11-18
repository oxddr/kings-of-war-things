include <common/kow.scad>;

module Pin() {
  Magnet(offset = -magnet_spacing);
}

module LInsert(size, unit_size, unit_type = "infantry") {
  base_num = BaseNum(unit_type, unit_size);
  base_size = BaseSize(unit_type);

  union() {
    width = size * base_size[0];
    length = base_num[1] * base_size[1];

    linear_extrude(height = base_height) {
      square(size =
                 [ width - 10 - insert_spacing, base_num[1] * base_size[1] ]);
      translate(v = [ 0, length - base_size[1] + insert_spacing]) {
        square(size = [ width - insert_spacing, base_size[1] - insert_spacing ]);
      }
    }
    translate(v = [ 0, 0, base_height ]) linear_extrude(height = pin_height) {
      translate(v = [ 5, 5 ]) Pin();
      translate(v = [ 5, length - 5 ]) Pin();
      translate(v = [ width - 5, length - 5 ]) Pin();

      if (size > 1) {
        translate(v = [ width - 5 - 10, 5 ]) Pin();
      }
    }
  }
}

module SideInsert(size, unit_size, unit_type = "infantry") {
  base_num = BaseNum(unit_type, unit_size);
  base_size = BaseSize(unit_type);

  union() {
    width = size * base_size[0];
    length = base_num[1] * base_size[1];

    linear_extrude(height = base_height) {
      difference() {
        square(size = [ width - insert_spacing, length ]);
        translate([width, length/2]) circle(0.5);
      }
    }
    translate(v = [ 0, 0, 3 ]) linear_extrude(height = pin_height) {
      translate(v = [ 5, 5 ]) Pin();
      translate(v = [ 5, length - 5 ]) Pin();
      if (size >= 1) {
        translate(v = [ width - 5, 5 ]) Pin();
        translate(v = [ width - 5, length - 5 ]) Pin();
      }
    }
  }
}