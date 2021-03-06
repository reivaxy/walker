 # Walking man laser zoetrope


I was very impressed with this 3D printed zoetrope:
https://www.youtube.com/watch?v=mAflS_s_aqo

So I wondered if I could design something more within my reach, because that structure really is too complex for me to replicate :)

Here is the result, which is not as impressive but nice enough.
<img src="https://github.com/reivaxy/walker/raw/master/resources/20190114_195919_001.jpg" width="500"/>

It's modular, you can easily dismantle it. Also, there is no glue involved, everything holds together (more or less) because it's tightly adjusted.

You can easily replace the 32 blades to make a different animation.


On this little video I had not painted all the top horizontal rods in black, so it kinda looks like a laser beam is going from the left walking guy to the right walking guy :)
https://www.youtube.com/watch?v=7O_N7arLvDw&feature=youtu.be

https://www.youtube.com/watch?v=tElLxCyTi0g&feature=youtu.be

To insure fluidity I have used two UEETEK 624ZZ 4mm x 13mm x 5mm bearings.

For the laser, I have used this (on the red laser video)
https://www.thingiverse.com/thing:1233024

For the blue laser video I've simply put a lens in front of a blue laserpen. I'll design a lens holder for laserpens.

Next steps: add a little motor, and a laser led support.

## Files

The marche*.png files have indications of support parts that should be painted black.

The marche00.scad is a template used by the script generateScad.sh to generate all marcheXX.scad files. Each file should then be edited to adjust the supporting rod dimensions.
(Which is why the line to create the scad files is commented out in the script, so that you do not inadvertently lose your work).

The generateStl.sh script will take all marcheXX.scad file to automatically generate the matching .stl file

The topRodLess directory contains the 32 frames with the top rod removed, and a 3mm thickness.

Such changes can easily be performed by modifying the values in common.scad (adjusting thickness) and the code in frame.scad (commenting out the top rod code), then use generateStl.sh

