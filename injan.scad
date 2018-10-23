
$fn = 256;
module injan (radius = 40, height = 5) {
    difference() {
        union () {
            difference() {
                cylinder(h = height, r=radius, d=radius);
                union () {
                    translate([-1 * radius/2,0,height/2])
                    cube([radius,radius/2,10]);
                    translate([radius/4,0,height/2])
                    cylinder(h=5, r=radius/2, d=radius/2);

                }
            }
            translate([-1 * radius/4, 0, 0])
            cylinder(h=height, r=radius/2, d=radius/2);
            translate([radius/4,0,0])
            cylinder(h=height, r=radius/8, d=radius/8);

        }
        translate([-1 * radius/4,0,height/2])
        cylinder(h=radius/4, r=radius/8, d=radius/8);
    }
}

injan(70, 2);