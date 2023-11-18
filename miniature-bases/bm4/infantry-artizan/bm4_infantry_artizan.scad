use <miniature-bases/libbase.scad>
use <common/kow.scad>

$fn = $preview ? 32 : 64;

base_size = BaseSize("infantry");
width = 9;
length = 19;
slot_start = 2.2;

difference() {
  BaseBM4("infantry", only_diagonal = true);

  translate([ 0, 0, slot_start ]) linear_extrude(height = 10) {
    hull() {
      m = length / 2 - width / 4;
      translate([ base_size[0] / 2 + m, base_size[1] / 2, 0 ]) scale([ 0.5, 1 ])
          circle(d = width);
      translate([ base_size[0] / 2 - m, base_size[1] / 2, 0 ]) scale([ 0.5, 1 ])
          circle(d = width);
    }
  }
}