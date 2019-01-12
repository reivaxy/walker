use <frame.scad>;

// Include the common values
include <common.scad>;

marche("04");

module marche(index) {
  translate([0, rodWidth - sink, z/2])
    scale([xyFactor, xyFactor, z])
      import(file = str("sequence/marche", index, ".svg_1mm.stl"));

  frame(index, radius, centerWidth, centerHeight, z, 0, 12, 9, 3, rodWidth);
}
