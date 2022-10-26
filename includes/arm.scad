module arm() {
    leftX = armDiameter / 2;
    rightX = armLength - armDiameter / 2;

    difference() {
        armWithCenterGap();

        //Left endhole
        translate([leftX, 0, -1]) endHole();

        //Right endhole
        translate([rightX, 0, -1]) endHole();

        //Left nubs are indentations
        translate([leftX, 0, armThickness - nubHeight + 0.001]) nubs(hole = true);
    }

    //Right nubs are raised
    translate([rightX, 0, armThickness]) nubs(hole = false);

    module endHole() {
        cylinder(d = endHoleDiameter, h = armThickness + 2);
    }
}

module armWithCenterGap() {
    translate([armDiameter / 2, 0, 0]) difference() {
        armShape(armAdjustedLength, armDiameter, armThickness);
        x = armAdjustedLength / 2 - armCenterGapLength / 2;
        translate([x, 0, -1]) armShape(armCenterGapLength, armDiameter - (2 * wallThickness), armThickness + 2);
    } 
}

module armShape(length, diameter, thickness) {
   echo("Length: ", length);
   echo("Diameter: ", diameter);
   echo("Thickness: ", thickness);
   linear_extrude(thickness)  hull() {
        circle(d = diameter);
        translate([length, 0, 0]) circle(d = diameter);
    }
}

module armScrewNut() {
    knurledNut(nutDiameter = nutDiameter, nutThickness = nutThickness, threadDiameter = armScrewDiameter, threadHeight = armScrewHeight, threadPitch = screwThreadPitch, threadHoleSlop = threadHoleAdjustment);
}

module armScrew() {
    knurledScrew(screwDiameter = armScrewDiameter, screwBaseDiameter = nutDiameter, screwBaseHeight = nutThickness, screwLength = armScrewHeight, screwThreadPitch = screwThreadPitch);
}

