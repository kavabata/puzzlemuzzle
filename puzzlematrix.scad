
module acube(
    size = 20, 
    radius = 5, 
    height = 3,
    t = false, 
    r = false,
    b = false, 
    l = false,
    tr = false,
    br = false,
    bl = false,
    tl = false

) {
    
    translate([radius, radius/2, 0])
    cube([size- radius, size, height]);

    translate([radius/2, radius, 0])
    cube([size, size-radius, height]);

    translate([size , size, 0])
    cylinder(height, radius/2, radius/2);

    translate([size , radius, 0])
    cylinder(height, radius/2, radius/2);

    translate([radius , radius, 0])
    cylinder(height, radius/2, radius/2);

    translate([radius , size, 0])
    cylinder(height, radius/2, radius/2);


    if (t) {
        translate([radius/2, size, 0])
        cube([size, radius, height]);
    }
    if (r) {
        translate([size, radius/2, 0])
        cube([radius, size, height]);
    }
    if (b) {
        translate([radius/2, 0, 0])
        cube([size, radius, height]);
    }
    if (l) {
        translate([0, radius/2, 0])
        cube([radius, size, height]);
    }

    if (t && r) {
        if (tr) {
            translate([size + radius/2, size + radius/2, 0])
            cube([radius/2, radius/2, height]);
        } else {       
            difference() {
                translate([size + radius/2, size + radius/2, 0])
                cube([radius * 1.5, radius * 1.5, height]);
            
                translate([size + radius * 2, size + radius * 2, -0.05])
                cylinder(height+0.1, radius * 1.5, radius * 1.5);  
            }
        }
    }

    if (t && l) {
        if (tl) {
            translate([0, size + radius/2, 0])
            cube([radius/2, radius/2, height]);
        } else {       
            difference() {
                translate([ -radius, size + radius/2, 0])
                cube([radius * 1.5, radius * 1.5, height]);
            
                translate([-radius, size + radius * 2, -0.05])
                cylinder(height+0.1, radius * 1.5, radius * 1.5);  
            }
        }
    }

    if (b && r) {
        if (br) {
            translate([size + radius/2, 0, 0])
            cube([radius/2, radius/2, height]);
        } else {
            difference() {
                translate([size + radius/2, -radius, 0])
                cube([radius * 1.5, radius * 1.5, height]);
            
                translate([size + radius * 2, -radius, -0.05])
                cylinder(height+0.1, radius * 1.5, radius * 1.5);  
            }
        }
    }

    if (b && l) {
        if (bl) {
            translate([0, 0, 0])
            cube([radius/2, radius/2, height]);
        } else {  
            difference() {
                translate([ -radius, -radius, 0])
                cube([radius * 1.5, radius * 1.5, height]);
            
                translate([-radius,-radius, -0.05])
                cylinder(height+0.1, radius * 1.5, radius * 1.5);  
            }
        }
    }
}

module puzzleborder (
    size = 4, 
    radius = 1, 
    height = 3, 
    cx = 3, 
    cy = 3
) {
    step  = size + radius;
    width = size - radius;
    translate([width, 0, 0])
    cube([cx * step , width, height]);

    translate([width, (cy) * step + width, 0])
    cube([cx * step , width, height]);

    translate([0, 0, 0])
    cube([width, cy * step + 2 * width, height]);

    translate([cx * step + width, 0, 0])
    cube([width, cy * step + 2 * width, height]);
        
    // plate
    translate([0, 0, -height/3])
    cube([cx * step + 2 * width, cy * step + 2 * width, height/3]);
}

module amatrix(
    ab, 
    cx = 3, 
    cy = 3, 
    firstlayer = false,
    size = 4, 
    radius = 1, 
    height = 3
) {
    step = size + radius;
    border = size - radius;

    for (y =[0:1:cy-1]){
        for (x =[0:1:cx-1]){
            if (ab[y][x] == 1) {
                if (firstlayer) {
                    translate([step * x + border, step * y + border, 0])
                    acube(
                        cubesize, 
                        cubedelta, 
                        cubeheight, 
                        ab[y+1][x] != 0, // top, 
                        ab[y][x+1] != 0, // right
                        ab[y-1][x] != 0, // bottom 
                        ab[y][x-1] != 0, // left 
                        ab[y+1][x+1] != 0, //tr
                        ab[y-1][x+1] != 0, //br
                        ab[y-1][x-1] != 0, //bl
                        ab[y+1][x-1] != 0 //tl
                    );
                } else {
                    translate([step * x + border, step * y + border, 0])
                    acube(
                        cubesize, 
                        cubedelta, 
                        cubeheight, 
                        ab[y+1][x] == 1, // top, 
                        ab[y][x+1] == 1, // right
                        ab[y-1][x] == 1, // bottom 
                        ab[y][x-1] == 1, // left 
                        ab[y+1][x+1] == 1, //tr
                        ab[y-1][x+1] == 1, //br
                        ab[y-1][x-1] == 1, //bl
                        ab[y+1][x-1] == 1 //tl
                    );
                }
            }
        }
    }
}

module puzzle(
    ab,
    firstlayer = false,
    size = 4, 
    radius = 1, 
    height = 3
) {
    step = size + radius;
    cx = len(ab[0]);
    cy = len(ab);
    
    echo ("Lets draw puzzle: ", cx, "x", cy);
    
    if (firstlayer) {
        echo ("First draw board...");
        color("yellow")
        puzzleborder(size, radius, height, cx, cy);
    }
    
    color("green")
    amatrix(ab, cx, cy, firstlayer, size, radius, height);
}
