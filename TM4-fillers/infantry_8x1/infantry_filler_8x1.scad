include <common/kow.scad>
include <miniature-bases/libbase.scad>

base_size = BaseSize("infantry");

linear_extrude(height = base_height) {
  difference() {
    square([ 8 * base_size[0], base_size[1] ]);
    MagnetSockets(unit_type = "infantry", only_diagonal = true) {
      MagnetHole();
    }
    translate([ 4.5 * base_size[0], 0 ]) {
      mirror([ 1, 0, 0 ]) {
        MagnetSockets(unit_type = "infantry", only_diagonal = true) {
          MagnetHole();
        }
      }
      translate([ 7 * base_size[0], 0 ]) {
        MagnetSockets(unit_type = "infantry", only_diagonal = true) {
          MagnetHole();
        }
      }
    }
  }
}