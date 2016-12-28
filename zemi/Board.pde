class Board{
  
  void updateSelectArea(){
    PImage koike = loadImage("koike.png");
    PImage kitabayashi = loadImage("kitabayashi.png");
    PImage mitui = loadImage("mitui.png");
    PImage kawazoe = loadImage("kawazoe.png");
    PImage uchida = loadImage("uchida.png");
    PImage ishijima = loadImage("ishijima.png");
    PImage yanagida = loadImage("yanagida.png");
    PImage ueda = loadImage("ueda.png");
    PImage takemoto = loadImage("takemoto.png");
    PImage aoki = loadImage("aoki.png");
    PImage ueyama = loadImage("ueyama.png");
    PImage shimizu = loadImage("shimizu.png");
    PImage akimoto = loadImage("akimoto.png");
    PImage kojima = loadImage("kojima.png");
    PImage sakoda = loadImage("sakoda.png");
    PImage tukamoto = loadImage("tukamoto.png");
    PImage nakata = loadImage("nakata.png");
    PImage fujimoto = loadImage("fujimoto.png");
    PImage nishimura = loadImage("nishimura.png");
    PImage inoue = loadImage("inoue.png");
    image(koike, 50,50,100,80);
    image(kitabayashi, 150,50,100,80);
    image(mitui, 280,50,100,80);
    image(kawazoe, 410,50,100,80);
    image(uchida, 510,50,100,80);
    image(ishijima, 660,50,100,80);
    image(yanagida, 760,50,100,80);
    image(ueda, 900,50,100,80);
    image(takemoto, 1000,50,100,80);
    image(aoki, 50,250,100,80);
    image(ueyama, 50,330,100,80);
    image(shimizu, 50,450,100,80);
    image(akimoto, 150,550,100,80);
    image(kojima, 250,550,100,80);
    image(sakoda, 380,550,100,80);
    image(tukamoto, 480,550,100,80);
    image(nakata, 580,550,100,80);
    image(fujimoto, 710,550,100,80);
    image(nishimura, 810,550,100,80);
    image(inoue, 910,550,100,80);
  }
  
    void updateCommentArea(String comment){
    fill(#FFFFFF);
    textSize(30);
    textAlign(CENTER);
    text(comment, 225, 190);
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