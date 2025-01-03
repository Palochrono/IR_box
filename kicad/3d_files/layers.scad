$fn = 100;
module pcb(){
    translate([-43,150,0])
    import("/home/samz/programming/kicad/keychron_hitbox/Unnamed-keychron_hitbox.stl");
}
//pcb();
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
switch_locations = [[15,51.7],[29.4,77.75],[57.4,80.25],[63.1,107.55],[84.4,69.25],[107.5,49.685],[136.4,54.95],[165,55.2],[194,55.2],[193.8,82.25],[166,82.2],[138.4,81.75],[111.5,77.8],[126.5,27.8]];
jump_locations =[[96.5,19.2]];
push_button_locations = [[30.55,116.275],[38.9,116.275],[22.4,116.275]];
module push_button_holes(){
    squares(push_button_locations, 9.1);
}
module screw_holes(){
    holes(screw_locations, 1.13);
}
module 23mm_switch_circular(){
    holes(switch_locations, 12.5);
}
module 26mm_switch_circular(){
    holes(jump_locations, 14);
}

module switches_back_slots(){
    squares(switch_locations, 15.4);
}
//switches_back_slots();

module pi_imprint(){
    translate([82.5,95,0])
    square([20,30]);
}

module oled_imprint(){
    translate([138,94,0])
    square([30,30]);
}
//oled_imprint();

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
        pi_imprint();
        oled_imprint();
    }
}
module switch_front_space(){
    difference(){
        plainbase();
        push_button_holes();
        screw_holes();
        26mm_switch_circular();
        23mm_switch_circular();
        pi_imprint();
        oled_imprint();
    }
}
bottom_cover();
//switch_back_space();
//pcb();
//switch_front_space();
//top_cover();