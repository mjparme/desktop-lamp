//desktopHolderLidDepth = (desktopHolderHeight - desktopHolderFloorThickness) / 3;  
desktopHolderLidDepth = 4;
desktopHolderHollowDiameter = desktopHolderOuterDiameter - (2 * desktopHolderWallThickess);
desktopHolderLidDiameter = desktopHolderHollowDiameter + (2 * (desktopHolderWallThickess / 2.0));

echo("***** DesktopHolder Calculated Values *****");
echo("desktopHolderLidDepth: ", desktopHolderLidDepth);
echo("desktopHolderHollowDiameter: ", desktopHolderHollowDiameter);
echo("desktopHolderLidDiameter: ", desktopHolderLidDiameter);

module desktopHolderBottom() {
    difference() {
        if (knurled) {
            knurledCylinder(height = desktopHolderHeight, outerDiameter = desktopHolderOuterDiameter, knurlDepth = 1);
        } else {
            cylinder(d = desktopHolderOuterDiameter, h = desktopHolderHeight, center = false);
        }

        //Hollows out the interior
        translate([0, 0, desktopHolderFloorThickness]) cylinder(d = desktopHolderHollowDiameter, h = desktopHolderHeight, center = false);
        
        //Creates the lip the lid sits on
        translate([0, 0, desktopHolderHeight - desktopHolderLidDepth]) cylinder(d = desktopHolderLidDiameter, h = desktopHolderHeight, center = false);
    }
}

module desktopHolderLid() {
    diameter = desktopHolderLidDiameter - desktopHolderLidSlop;
    cylinder(d = diameter, h = desktopHolderLidDepth, center = false);
    x = armThickness / 2;
    y = -armDiameter / 2;
    z = desktopHolderLidDepth - 0.01;
    translate([x, y, z]) rotate([0, -90, 0]) connector(totalLength = 45, nubsAreHoles = false, includeNubs = true, includeFillet = true);
}