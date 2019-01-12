
include <common.scad>;

diam = centerWidth*2 + 30;
thick = 6;
tol = 0.1;

bearerExtDiam = 13;
bearerIntDiam = 4;
bearerZ = 5;
axleHeight = centerHeight;

plate();
//axle();

module axle() {
  difference() {
    cylinder(d=bearerIntDiam, h=axleHeight, $fn=150);
    scale([1.2, 1, 1])
      cylinder(d=bearerIntDiam-1.4, h=axleHeight, $fn=150);
    translate([-bearerIntDiam/2, -1/2, 0])
      cube([bearerIntDiam, 1, axleHeight]);
  }
  rotate([0, 0, 90])
    translate([-bearerIntDiam/2+0.25, -1/2, 0])
      cube([bearerIntDiam - 0.5, 1, axleHeight]);
}

module plate() {
  difference() {
    cylinder(d=diam, h=thick, $fn=150);
    nickSet(centerWidth, z, 32);

    // Bearer hole
    translate([0, 0, thick - bearerZ - tol])
      cylinder(d=bearerExtDiam, h=bearerZ + 1, $fn=150);

    translate([0, 0, -1])
      cylinder(d=bearerIntDiam + 2, h=thick, $fn=150);

  }
}

module nickSet(x, y, count) {
  for (nick = [0 : count - 1]) {
    angle = nick * 360 / count;
    rotate([0, 0, angle])
      translate([diam/2 - centerWidth , -(y + tol)/2, thick - 2 + tol])
        cube([x + tol, y + tol, thick]);
  }

}