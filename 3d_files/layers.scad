$fn = 100;
module pcb(){
    translate([-43,150,0])
    import("/home/samz/programming/kicad/IR_box/kicad/Unnamed.stl");
}


module plainbase(x_size=208.5,y_size=125,corner_radius=10){
    translate([corner_radius,corner_radius,0])
    offset(r=corner_radius)
    square([x_size-2*corner_radius,y_size-2*corner_radius]);
}
//plainbase();

module hole(x_offset,y_offset,radius){
    translate([x_offset,y_offset,0])
    circle(radius);
}

module switch_plate_imprint(size = 13.8, catch_x = 3, catch_y=0){
    difference(){
        square(size, center=true);
        translate([0,size/2,0])
        square([catch_x,catch_y*2], center=true);
        translate([0,-size/2,0])
        square([catch_x,catch_y*2], center=true);
    }
}
module switch_plate_imprints(pos_array){
    for (a = [ 0 : len(pos_array) - 1 ]) 
    {
        point=pos_array[a];
        translate([point[0],point[1],0])
        switch_plate_imprint();
    }
}

module holes(pos_array,radius){
    for (a = [ 0 : len(pos_array) - 1 ]) 
    {
        point=pos_array[a];
        hole(point[0],point[1],radius);
    }
}

module squares(pos_array,size){
    for (a = [ 0 : len(pos_array) - 1 ]) 
    {
        point=pos_array[a];
        translate([point[0],point[1],0])
        square(size, center = true);
    }
}

screw_locations = [[9.5,7.5],[114.5,7.5],[194.5,7.5],[9.5,117.5],[194.5,117.5]];
//switch_locations = [[15,51.7],[29.4,77.75],[57.4,80.25],[63.1,107.55],[84.4,69.25],[107.5,49.685],[136.4,54.95],[165,55.2],[194,55.2],[193.8,82.25],[166,82.2],[138.4,81.75],[111.5,77.8],[126.5,27.8],[121.4,107.75]];
switch_locations = [[15,51.7],[29.4,77.75],[57.4,80.25],[63.1,107.55],[84.4,69.25],[107.5,49.685],[136.4,54.95],[165,55.2],[194,55.2],[193.8,82.25],[166,82.2],[138.4,81.75],[111.5,77.8],[126.5,27.8]];
jump_locations =[[96.5,19.2]];
//push_button_locations = [[27.,116.1],[34.55,116.1],[43.5,116.1],[18,116.1]];
push_button_locations = [[30.55,116.275],[38.9,116.275],[22.4,116.275]];

module push_button_holes(){
    squares(push_button_locations, 9.5);
    //squares(push_button_locations, 2.5);
}

module screw_holes(){
    holes(screw_locations, 1.12);
}
module 23mm_switch_circular(){
    holes(switch_locations, 12.5);
    //holes(switch_locations, 1.5);
}

module 26mm_switch_circular(){
    holes(jump_locations, 14);
}

module switches_back_slots(){
    squares(switch_locations, 15.4);
    squares(jump_locations, 15.4);
}

module switches_front_slots(){
    squares(switch_locations, 16);
    squares(jump_locations, 16);
}

module switch_plate_holes(){
    switch_plate_imprints(switch_locations);
    switch_plate_imprints(jump_locations);
}

module pi_imprint(){
    translate([82.5,97,0])
    square([20,28]);
}
module pi_imprint(){
    translate([82.5,95,0])
    square([20,30]);
}

module oled_imprint(){
    translate([138,94.5,0])
    square([30,29]);
}
module usb_imprint(){
    translate([0,85.4])
    square([17,20]);
}


module top_cover(){
    difference(){
        plainbase();
        push_button_holes();
        26mm_switch_circular();
        23mm_switch_circular();
        screw_holes();
    }
}
module bottom_cover(){
    difference(){
        plainbase();
        screw_holes();
    }
}
module switch_back_space(){
    difference(){
        plainbase();
        screw_holes();
        switches_back_slots();
        oled_imprint();
    }
}
module switch_front_space(){
    difference(){
        plainbase();
        push_button_holes();
        screw_holes();
        switches_front_slots();
        pi_imprint();
        oled_imprint();
        usb_imprint();
    }
}
module switch_front_plate(){
    difference(){
        plainbase();
        push_button_holes();
        screw_holes();
        switch_plate_holes();
        oled_imprint();
        pi_imprint();
        usb_imprint();
    }
}
module switch_top_cover_space(){
    difference(){
        plainbase();
        push_button_holes();
        26mm_switch_circular();
        23mm_switch_circular();
        screw_holes();
        oled_imprint();
        usb_imprint();
        pi_imprint();
    }
}

module testing_holes(){
    translate([10,50,0])
    switch_plate_imprint(size = 13.6, catch_x = 3, catch_y=0.2);
    translate([30,50,0])
    switch_plate_imprint(size = 13.7, catch_x = 3, catch_y=0.2);
    translate([50,50,0])
    switch_plate_imprint(size = 13.8, catch_x = 3, catch_y=0.2);
    translate([70,50,0])
    switch_plate_imprint(size = 13.9, catch_x = 3, catch_y=0.2);
    translate([90,50,0])
    switch_plate_imprint(size = 14.0, catch_x = 3, catch_y=0.2);
    translate([110,50,0])
    switch_plate_imprint(size = 14.1, catch_x = 3, catch_y=0.2);
    translate([130,50,0])
    switch_plate_imprint(size = 14.2, catch_x = 3, catch_y=0.2);
    translate([150,50,0])
    switch_plate_imprint(size = 14.3, catch_x = 3, catch_y=0.2);
    translate([170,50,0])
    switch_plate_imprint(size = 14.4, catch_x = 3, catch_y=0.2);
    translate([190,50,0])
    switch_plate_imprint(size = 14.5, catch_x = 3, catch_y=0.2);
}

module plate_test(){
    difference(){
        plainbase();
        push_button_holes();
        screw_holes();
        pi_imprint();
        oled_imprint();
        testing_holes();
    }
}
//bottom_cover();
//switch_back_space();
//switch_front_space();
switch_front_plate();
//switch_top_cover_space();
//pcb();
//top_cover();
//plate_test();