
$fn = 256;
module bio (radius = 40, height = 5, k = 90) {
    difference () {
        cylinder(height, radius, radius);
        
        translate([radius * (100 - k)/100, 0, height/2])
        cylinder(height, radius * k/100, radius * k/100);
    }
}

module biohaazrd(radius = 40, move = 10, height = 5, k = 90) {
    translate([move,0, 0])
    bio(radius, height, k);

    rotate(120)
    translate([move,0, 0])
    bio(radius, height, k);

    rotate(240)
    translate([move,0, 0])
    bio(radius, height, k);
}

biohaazrd(20, 13, 3, 88);