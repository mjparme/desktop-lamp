module g10BulbHolder() {
    connector(totalLength = armConnectorTotalLength, nubsAreHoles = true);
    x = -armThickness + 0.001;
    y = armDiameter;
    z = 0;
    translate([x, y, z]) rotate([0, -90, 180]) bulbSection(totalLength = bulbConnectorTotalLength);
}

module bulbSection(totalLength) {
    bulbExtensionHeight = 5.5;
    extraLength = totalLength - armDiameter + armThickness;
    x = -armDiameter / 2 - extraLength;
    y =  -armDiameter / 2;
    z = 0;

    translate([x * -1, armDiameter / 2, 0]) difference() {
        mainShape();
        translate([0, 0, -1]) cylinder(d = g10HoleInnerDiameter, h = armThickness + bulbExtensionHeight + 2);
    }

    module mainShape() {
        hull() {
            cylinder(d = armDiameter, h = armThickness);
            translate([x, y, z]) cube([0.01, armDiameter, armThickness]);
        }

        translate([0, 0, armThickness]) hollowCylinder(outerDiameter = armDiameter, innerDiameter = g10HoleInnerDiameter, topOuterDiameter = undef, 
        topInnerDiameter = undef, height = bulbExtensionHeight, center = false, hasFloor = false, rounded = "top", floorThickness = undef);
    }
}