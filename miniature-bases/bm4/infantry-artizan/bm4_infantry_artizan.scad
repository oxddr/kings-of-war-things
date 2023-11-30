use <common/kow.scad>
use <miniature-bases/libbase.scad>

$fn = $preview ? 32 : 64;

base_size = BaseSize("infantry");
length = 19;
slot_start = 2.2;

module Base(w) {
  difference() {
    BaseBM4("infantry", only_diagonal = true);

    translate([ 0, 0, slot_start ]) linear_extrude(height = 10) {
      hull() {
        m = length / 2 - width / 4;
        translate([ base_size[0] / 2 + m, base_size[1] / 2, 0 ])
            scale([ 0.5, 1 ]) circle(d = width);
        translate([ base_size[0] / 2 - m, base_size[1] / 2, 0 ])
            scale([ 0.5, 1 ]) circle(d = width);
      }
    }
  }
}

Base(width);