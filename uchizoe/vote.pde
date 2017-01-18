
class Vote {

  void updateSelectArea() {
    PImage gu = loadImage("hot.png");
    PImage choki = loadImage("cold.png");
    PImage pa = loadImage("good.png");
    PImage good =loadImage("good.png");
    PImage bad =loadImage("bad.png");
    
    image(gu, 750, 75, 65, 50);
    image(pa, 825, 75, 65, 50);
    image(choki, 905, 75, 65, 50);
    image(good,750,150,100,50);
    image(bad,875,150,100,50);
    image(good,750,225,100,50);
    image(bad,875,225,100,50);
  

  }

  void updateResultArea(String result2) {
    fill(255);
    //rect(0,225,450,75);
    //fill(0);
   // textSize(45);
   // textAlign(CENTER);
   // text(result2, 225, 260);
    textAlign(LEFT);
  }