class team{
  
  void teampage(){
    PImage gt_room1 = loadImage("gt_room1.png");
    PImage gt_rooms2 = loadImage("gt_rooms2.png");
    PImage gt_room2 = loadImage("gt_room2.png");
    PImage gt_iot = loadImage("gt_iot.png");
    PImage gt_game = loadImage("gt_game.png");
    PImage gt_task = loadImage("gt_task.png");
    
    image(gt_room1, 30,30,240,120);
    image(gt_rooms2, 270,30,120,120);
    image(gt_room2, 390,30,240,120);
    image(gt_game, 640,30,240,120);
    image(gt_iot, 900,30,240,120);
    image(gt_task, 30,230,140,200);
  }
}