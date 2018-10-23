
$fn = 256;
module rad (radius = 40, height = 5) {
    difference () {
        cylinder(height, radius, radius);
        
        union() {
            translate([0, 0, height/2])
            cylinder(height, radius/3, radius/3);
            
            translate([-1 * radius, 0, height/2])            
            cube([radius *2, radius, height]);

            rotate(210)
            translate([0, -1 * radius, height/2])
            cube([radius, radius * 2, height]);
        }
    }
}

module radioactive(radius = 40, height = 5) {
    
    rad(radius, height);

    rotate(120)
    rad(radius, height);

    rotate(240)
    rad(radius, height);

    cylinder(height, radius/5, radius/5);
}

