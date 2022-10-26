module fixedTableClamp() {
    mainClamp();
    //Substracting the clamp outer round radius fills in the gap on the border with the connector caused 
    //by the tableClamp being rounded
    x = clampInnerLength + clampThickness - clampOuterRoundedRadius;
    y = clampWidth;
    z = 0;
    translate([x, y, z]) rotate([90, 0, 0]) connector(totalLength = 40, nubsAreHoles = false);
}

module swivelTableClamp() {
    mainClamp();
    x = clampInnerLength + clampThickness - clampOuterRoundedRadius;
    translate([x, 0, 0]) topBottomConnectors();

    module topBottomConnectors() {
        totalLength = 35;
        connector(totalLength = totalLength, nubsAreHoles = false, includeNubs = false, includeFillet = false); 
        z = clampInnerHeight + 2 * clampThickness - armThickness;
        translate([0, 0, z]) connector(totalLength = totalLength, nubsAreHoles = false, includeNubs = false, includeFillet = false); 
    }
}

module swivelTableClampConnector() {
    echo("***** Swivel Table Clamp Connector *****");
    //Adding a bit here to the height because we want a good friction fit on this so the lamp swivels but does swing around wildly
    //with the slightest bump
    swivelHeight = clampHeight - 2 * armThickness + 0.2;
    echo("SwivelHeight: ", swivelHeight);
    swivelConnector(totalLength = 40, includeNubs = true, nubsAreHoles = false, swivelWallThickness = 3, swivelInsideDiameter = endHoleDiameter, 
        swivelHeight = swivelHeight);
}

module mainClamp() {
    clamp(clampInnerLength = clampInnerLength, clampWidth = clampWidth, clampInnerHeight = clampInnerHeight, clampThickness = clampThickness, innerRoundedRadius = clampInnerRoundedRadius, 
        outerRoundedRadius = clampOuterRoundedRadius, screwDiameter = clampScrewDiameter, screwThreadPitch = clampScrewThreadPitch, threadHoleAdjustment = threadHoleAdjustment);
}

module tableClampScrew() {
    knurledScrew(screwDiameter = clampScrewDiameter, screwBaseDiameter = clampScrewBaseDiameter, screwBaseHeight = clampScrewBaseHeight, screwLength = clampScrewLength, 
        screwThreadPitch = screwThreadPitch);
}

//The screw the swivel piece of the swivel table clamp swivels on, it is an arm screw just longer
module swivelScrew() {
    swivelScrewHeight = clampHeight + nutThickness + 1;
    knurledScrew(screwDiameter = armScrewDiameter, screwBaseDiameter = nutDiameter, screwBaseHeight = nutThickness, screwLength = swivelScrewHeight, screwThreadPitch = screwThreadPitch);
}