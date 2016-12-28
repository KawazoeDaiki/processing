class Board {

  void updateSelectArea() {
    PImage gu = loadImage("hot.png");
    PImage choki = loadImage("cold.png");
    PImage pa = loadImage("good.png");
    image(gu, 0, 0, 200, 150);
    image(choki, 200, 0, 200, 150);
    image(pa, 400, 0, 200, 150);
  }

  void updateCommentArea(String comment){
    fill(#FFFFFF);
    textSize(30);
    textAlign(CENTER);
    text(comment, 285, 190);
  }

  void updateResultArea(String result) {
    fill(#000000);
    rect(0,225,450,75);
    fill(#FFFFFF);
    textSize(45);
    textAlign(CENTER);
    text(result, 225, 260);
  }
}