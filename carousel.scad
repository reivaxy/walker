
include <common.scad>;

diam = centerWidth*2 + 30;
thick = 6;
tol = 0.1;

bearerExtDiam = 13;
bearerIntDiam = 4;
bearerZ = 5;

footZ = 6;
footLength = 150;
footWidth = 15;

nickDepth = 2;

full() ;
//plate();
//axle(centerHeight + 30);
//foot();

//rotate([0, -90, 0]) laserHolder();
//ballSocket();

//ballRodHolder();
//ballRod();

module full() {
  plate();
  walker(centerWidth, z, 32);
  translate([0, 0, centerHeight + thick + nickDepth])
    rotate([180, 0, 0])
      plate();
  translate([0, 0, -10])
    axle(centerHeight + 30);
  translate([-footLength/2, footWidth/2, -6])
    rotate([180, 0, 0])
      foot();
}

lensDiam = 8.1;
lensThick = 1.7;
ledHoleDiam = 3;
ledDiam = 6.3;
wall = 1.2;
tubeLength = 15;
tubeSide = lensDiam + wall;
ballSocketAngle = 25;

module ballRod() {
  axle(50);
  translate([0, 0, 50])
    cylinder(d=2, h = 4, $fn=10);
  translate([0, 0, 54])
    sphere(d=ballDiam, $fn=40);
}

module ballRodHolder() {
  difference() {
    cube([10, 10, 10]);
    translate([5,5,5])
      cylinder(d=bearerIntDiam + tol, $fn=50, h=5);
    translate([0, 5, 0])
      rotate([0, 45, 0])
        cylinder(d=bearerIntDiam + tol, $fn=50, h=6);
  }

}

module laserHolder() {
  difference() {
    translate([-tubeSide/2, -tubeSide/2, 0])
      cube([tubeSide*2, tubeSide, tubeLength]);

    // tilted long side
    rotate([0, 15, 0])
      translate([tubeSide/2, -tubeSide/2, -tubeLength/2])
        cube([tubeSide, tubeSide, tubeLength*2]);
    // tilted short side
    rotate([0, -ballSocketAngle, 0])
      translate([tubeSide + 1.5, -tubeSide/2, -tubeLength/2])
        cube([tubeSide, tubeSide, tubeLength*2]);

    // lens slot
    translate([0, 0, 0.6])
      cylinder(d=lensDiam + tol, $fn=100, h = lensThick + tol);
    // led tube
    translate([0, 0, 0.6 + lensThick])
      cylinder(d=ledDiam + tol, $fn=100, h = tubeLength);
    // light hole
    cylinder(d=ledHoleDiam, $fn=100, h = tubeLength);
    // lens slot opening
    color("blue")
    translate([-(lensDiam+tol)/2, 0, 0.6])
      cube([lensDiam, tubeSide/2, lensThick + tol]);
  }
  translate([10, 0, tubeLength-1])
    rotate([0, 90 - ballSocketAngle -180, 0])
      ballSocket();
}

ballDiam = 4;
socketDiam = 5;

module ballSocket() {
  difference() {
    cylinder(d=socketDiam, h = 6, $fn=100);
    translate([0, 0, -ballDiam])
      sphere(d = 4+tol, $fn=100);
    cylinder(d = 4-tol, $fn=100, h=ballDiam);
    translate([-0.3, -5, 0])
      cube([0.6, 10, ballDiam]);
    translate([-5, -0.3, 0])
      cube([10, 0.6, ballDiam]);
  }


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

module axle(axleHeight) {
  thinner = 1.4;
  difference() {
    scale([1.1, 1, 1])
      cylinder(d=bearerIntDiam - 2*tol, h=axleHeight, $fn=150);
    scale([1.4, 1, 1])
      cylinder(d=bearerIntDiam-thinner, h=axleHeight, $fn=150);
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