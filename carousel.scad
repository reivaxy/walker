
include <common.scad>;

diam = centerWidth*2 + 30;
thick = 6;
tol = 0.1;

bearerExtDiam = 13;
bearerIntDiam = 4;
bearerZ = 5;
axleHeight = centerHeight + 50;

footZ = 6;
footLength = 150;
footWidth = 15;

nickDepth = 2;
//plate();
//axle(1.4);
//foot();

full() ;



module full() {
  plate();
  walker(centerWidth, z, 32);
  translate([0, 0, centerHeight + thick + nickDepth])
    rotate([180, 0, 0])
      plate();
}

module foot() {
  difference() {
    union() {
      footPart();
      translate([(footLength + footWidth)/2, -(footLength - footWidth)/2, 0])
        rotate([0, 0, 90])
          footPart();
    }
    translate([footLength/2, footWidth/2, -1])
      cylinder(d = bearerIntDiam + tol, h = footZ + 2);
  }
}

module footPart() {
  cube([footLength, footWidth, footZ]);
  translate([footZ, footWidth/2, footZ])
    sphere(r=footZ, $fn=100);
  translate([footLength-footZ, footWidth/2, footZ])
    sphere(r=footZ, $fn=100);

}

module axle(thin) {
  difference() {
    scale([1.1, 1, 1])
      cylinder(d=bearerIntDiam - 2*tol, h=axleHeight, $fn=150);
    scale([1.4, 1, 1])
      cylinder(d=bearerIntDiam-thin, h=axleHeight, $fn=150);
    translate([-bearerIntDiam, -1/2, 0])
      cube([bearerIntDiam * 2, 1, axleHeight]);
  }
  rotate([0, 0, 31.5])
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
      translate([diam/2 - centerWidth , -(y + tol)/2, thick - nickDepth + tol])
        cube([x + tol, y + tol, thick]);
  }
}

prefix = "";
module walker(x, y, count) {
  for (nick = [0 : count - 1]) {
    angle = nick * 360 / count;
    rotate([0, 0, angle])
      translate([radius + diam/2 - centerWidth , -(y + tol)/2, thick - 2 + tol])
        rotate([90, 0, 0])
          rotate([0, 180, 0])
            if (nick < 9)
              import(file = str("marche0", nick + 1, ".stl"));
            else
              import(file = str("marche", nick + 1, ".stl"));

  }
}