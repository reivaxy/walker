
//frame("01", 100, 15, 50, 2, 1, 3, 10, 10, 2);


module frame(index, radius, x, y, z, 
             btmOffset, topOffset, xVertRod, yVertRod, rodWidth) {
  translate([radius - x, 0, 0])
    difference() {
      cube([x, y, z]);
      // order index
      translate([4, y/2 + 2, z/2])
      linear_extrude(height = z)
            text(text=str(index), size=4, valign="top", halign="center", font="Microsoft Sans Serif Normal:bold");

    }

  // Bottom rod
  translate([btmOffset, 0, 0])
    cube([radius - btmOffset, rodWidth, z]);

  // Top rod
  translate([topOffset, y - rodWidth, 0])
    cube([radius - topOffset, rodWidth, z]);

  // Vertical rod
  translate([xVertRod, 0, 0])
    cube([rodWidth, yVertRod, z]);
}