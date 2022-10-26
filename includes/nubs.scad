module nubs(hole = false) {
    echo("***** Nubs *****");
    length = hole == false ? nubLength : nubLength + 1;
    width = hole == false ? nubWidth : nubWidth + 1;
    height = hole == false? nubHeight : nubHeight + 0.5;
    echo(str("Hole? ", hole, ", NubLength: ", length, ", NubWidth: ", width, ", NubHeight: ", height));

    plotCircle(radius = endHoleDiameter / 2 + nubWidth - 0.5, numOfPoints = 12, rotatePerpendicularToCenter = true) {
        nub();
    }

    module nub() {
        translate([0, 0, height / 2]) cube([length, width, height], center = true);
    }
}