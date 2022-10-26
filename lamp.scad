use <../../lib/paths.scad>
use <../../lib/bosl/constants.scad>
use <../../lib/knurled/knurledFinishLib-v2.scad>
include <../../lib/bosl/threading.scad>
use <../../lib/tableClamp.scad>
use <../../lib/knurledScrew.scad>
use <../../lib/triangles.scad>
use <../../lib/cylinders.scad>
use <../../lib/cubes.scad>


include <./config/config.scad>
include <./includes/arm.scad>
include <./includes/nubs.scad>
include <./includes/tableClamp.scad>
include <./includes/connector.scad>
include <./includes/g10BulbHolder.scad>
include <./includes/desktopHolder.scad>

$fn = $preview ? 30 : 100;

clampScrewLength = clampInnerHeight;

armAdjustedLength = armLength - armDiameter;
armCenterGapLength = armAdjustedLength - (1.8 * armDiameter);
armScrewDiameter = endHoleDiameter - 1;
//3.2 because screw needs to go through 2 arms and one nut (which is same thickness as arm) then a smidge extra
armScrewHeight = armThickness * 3.2;
clampHeight = clampInnerHeight + 2 * clampThickness;

echo("***** Lamp Main *****");
echo("AdjustedLength: ", armAdjustedLength);
echo("CenterGapLength: ", armCenterGapLength);

//PART = "arm";
//PART = "armScrew";
//PART = "armScrewNut";
//PART = "armScrewNutAndScrew";
//PART = "g10BulbHolder";
//PART = "swivelTableClampConnector";
//PART = "desktopHolderLid";
//PART = "desktopHolderBottom";
//PART = "swivelTableClamp";
//PART = "swivelScrew";
PART = "fixedTableClamp";

if (PART == "arm") {
    arm();
} else if (PART == "armScrewNut") {
    armScrewNut();
} else if (PART == "armScrew") {
    armScrew();
} else if (PART == "armScrewNutAndScrew") {
    armScrewNut();
    translate([nutDiameter + 5, 0, 0]) armScrew();
} else if (PART == "fixedTableClamp") {
    fixedTableClamp();
} else if (PART == "swivelTableClamp") {
    swivelTableClamp();
} else if (PART == "swivelTableClampConnector") {
    swivelTableClampConnector();
} else if (PART == "tableClampScrew") {
    tableClampScrew();
} else if (PART == "swivelScrew") {
    swivelScrew();
} else if (PART == "g10BulbHolder") {
    g10BulbHolder();
} else if (PART == "desktopHolderBottom") {
    desktopHolderBottom();
} else if (PART == "desktopHolderLid") {
    desktopHolderLid();
} 