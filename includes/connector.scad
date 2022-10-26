//This connector is used for any piece that needs to connect to an arm that is not an arm (table clamp, bulb holder, etc)
module connector(totalLength = 50, nubsAreHoles = false, includeNubs = true, includeFillet = true) {
    //Need to calculate x here because we need it to position the connector at the origin because x is the position of the cube 
    //we hull with and the cube is the left most part of the connector. The cylinder is at the origin, the cube is moved to the left
    //this makes differencing the hole and adding the nubs easier
    extraLength = totalLength - armDiameter;
    echo("ConnectorExtraLength: ", extraLength);
    x = -armDiameter / 2 - extraLength;

    translate([x * -1, armDiameter /  2, 0]) mainShape(leftMostPosition = x, nubsAreHoles = nubsAreHoles, includeNubs = includeNubs, includeFillet = includeFillet);
}

//TotalLength does not include the part use to swivel on
module swivelConnector(totalLength = 50, includeNubs = true, nubsAreHoles = false, swivelWallThickness = 3, swivelInsideDiameter = 15, swivelHeight = 30) {
    length = swivelInsideDiameter + 2 * swivelWallThickness;
    connector(totalLength = totalLength, nubsAreHoles = nubsAreHoles, includeNubs = includeNubs, includeFillet = false);
    x = -length + 2;
    y = armDiameter / 2 - swivelHeight / 2;
    z = 0;
    translate([x, y, z]) swivel();

    module swivel() {
        width = length;
        x = length / 2;
        y = swivelHeight / 2;
        z = width / 2;
        //This translate just gets the swivel back to the origin, we will put it where it goes in the outer module where it is called
        translate([x, y, z]) rotate([90, 0, 0]) difference() {
            roundedCube(length = length, width = width, height = swivelHeight, radius = 2, center = true, roundingShape = "sphere", topRoundingShape = undef);
            cylinder(d = swivelInsideDiameter, h = swivelHeight + 2, center = true);
        }
    }
}

 //The dimensions of the connector is closely related to the arm because we basically want an arm end as the connector
module mainShape(leftMostPosition, nubsAreHoles = false, includeNubs = true, includeFillet = true) {
    nubsZ = nubsAreHoles ? armThickness - nubHeight + 0.001 : armThickness;
    echo("NubZ: ", nubsZ);
    echo("NubHole?: ", nubsAreHoles);

    y =  -armDiameter / 2;
    z = 0;
    difference() {
        hull() {
            cylinder(d = armDiameter, h = armThickness);
            translate([leftMostPosition, y, z]) cube([0.01, armDiameter, armThickness]);
        }

        translate([0, 0, -1]) cylinder(d = endHoleDiameter, h = armThickness + 2);
        echo(str("includeNubs: ", includeNubs, ", nubsAreHoles: ", nubsAreHoles));
        if (includeNubs && nubsAreHoles) {
            translate([0, 0, nubsZ]) nubs(hole = nubsAreHoles);
        }
    }

    if (includeNubs && !nubsAreHoles) {
        translate([0, 0, nubsZ]) nubs(hole = nubsAreHoles);
    }

    if (includeFillet) {
        filletSize = 5;
        filletX = leftMostPosition;
        filletY = -armDiameter / 2;
        filletZ = armThickness;
        translate([filletX, filletY, filletZ]) rightTriangle(filletSize, filletSize * 2, armDiameter);
    }
}