class uchi_main {
  MongoClient mongo;
  MongoCollection<Document> collection;
  MongoCollection<Document> colTemp, colCo2, colNoise;
  Vote vote;
  Game game;
  String userName;
  String type;

  FindIterable<Document> result;
  float n;
  Document[] docs = new Document[5];
  Document latest;
  int fnct;

  String tmpTemp = "none";
  String tmpCO2 = "none";
  String tmpSound = "none";

  void setup() {

    //MongoDBサーバーに接続
    mongo = new MongoClient("150.89.234.253", 27018);
    //利用するデータベースを取得
    MongoDatabase database = mongo.getDatabase("test");
    //利用するコレクション名(テーブル)を指定
    collection = database.getCollection("netatmotest");
    colCo2 = database.getCollection("feeling-co2");
    colTemp = database.getCollection("feeling-temperature");
    colNoise = database.getCollection("feeling-sound");

    for (Document doc : collection.find()) {
      System.out.println(doc.toJson());
    }

    //size(1000, 600);
    //background(256, 256, 256);
    fill(0);
    line(0, 300, 1000, 300);
    result = collection.find().sort(Sorts.descending("date"));
    latest = result.first();

    vote = new Vote();
    game = new Game();

    //String t = null;
    Float tem = 0.0;
    //Integer Humidity = 0;
    Integer CO2 = 0;
    Integer Noise = 0;
    //Float Pressure = 0.0;


    // String t = h + ":" + nf(m, 2) + ":" + nf(s, 2);


    for (Document doc : result) {
      System.out.println(doc); 

      tem = latest.getDouble("tem").floatValue();
      //  Humidity = latest.getInteger("Humidity");
      CO2 = latest.getInteger("CO2");
      Noise = latest.getInteger("Noise");
      //  Pressure = latest.getDouble("Pressure").floatValue();
    }

    //textSize(20);
    textFont(createFont("MSGothic", 25));
    //text("time :"+t, 600, 75);
    text("室温 : "+tem + "℃", 550, 112.5);
    // text("Humidity : " + Humidity + "%", 550,125);
    text("CO2 : " + CO2 + "ppm", 550, 187.5);     
    text("騒音 : " + Noise + "dB", 550, 250);     
    //text("Pressure : " +Pressure + "mb", 550,206.5);

    fnct = 0;
    userName = System.getProperty("user.name");
  }

  void draw() {

    int cnt = 0;
    int s = second();
    int m = minute();
    int h = hour();  
    String t = null;
    t = h + ":" + nf(m, 2) + ":" + nf(s, 2);
    textSize(30);
    //text("time :"+t, 550, 30);

    vote.updateSelectArea();



    if (cnt <= 1) {
      fill(256, 256, 256);
      noStroke();
      rect(450, 50, 200, 30);

      fill(0);
      textAlign(CENTER);
      text("time :"+t, 550, 75);

      //ボタンの位置//
      // fill(0,0,255);
      // rect(750,75,65,50);

      // fill(0,255,0);
      // rect(825,75,65,50);

      // fill(255,0,0);
      // rect(905,75,65,50);

      // fill(255);
      // rect(750,150,100,50);

      // fill(256,256,0);
      // rect(875,150,100,50);

      // fill(255);
      // rect(750,225,100,50);

      // fill(256,256,0);
      // rect(875,225,100,50);

      //室温の押した際の赤枠処理

      fill(0, 0, 0, 0);
      if ( tmpTemp.equals("hot") ) {
        //hot赤枠
        stroke(255, 0, 0);
        rect(750, 75, 65, 50);
      } else {
        //hot白枠
        stroke(255);
        rect(750, 75, 65, 50);
      }
      if ( tmpTemp.equals("good") ) {
        //hot赤枠
        stroke(255, 0, 0);
        rect(825, 75, 65, 50);
      } else {
        //hot白枠
        stroke(255);
        rect(825, 75, 65, 50);
      }
      if ( tmpTemp.equals("cold") ) {
        //good赤枠
        stroke(255, 0, 0);
        rect(905, 75, 65, 50);
      } else {
        //good白枠
        stroke(255);
        rect(905, 75, 65, 50);
      }

      //CO2押した時の赤枠処理

      if ( tmpCO2.equals("good") ) {
        //good赤枠
        stroke(255, 0, 0);
        rect(750, 150, 100, 50);
      } else {
        //good白枠
        stroke(255);
        rect(750, 150, 100, 50);
      }

      if ( tmpCO2.equals("bad") ) {
        //good赤枠
        stroke(255, 0, 0);
        rect(875, 150, 100, 50);
      } else {
        //good白枠
        stroke(255);
        rect(875, 150, 100, 50);
      }


      //騒音押した時の赤枠処理

      if ( tmpSound.equals("good") ) {
        //good赤枠
        stroke(255, 0, 0);
        rect(750, 225, 100, 50);
      } else {
        //good白枠
        stroke(255);
        rect(750, 225, 100, 50);
      }

      if ( tmpSound.equals("bad") ) {
        //good赤枠
        stroke(255, 0, 0);
        rect(875, 225, 100, 50);
      } else {
        //good白枠
        stroke(255);
        rect(875, 225, 100, 50);
      }

      noStroke();
    }
    
    
    cnt++;

    fnct++;
    if (fnct >= 18000) {
      size(1000, 600);
      //background(255, 255, 255);
      fill(0);
      line(0, 300, 1000, 300);
      result = collection.find().sort(Sorts.descending("date"));
      latest = result.first();

      Float tem = 0.0;
      //Integer Humidity = 0;
      Integer CO2 = 0;
      Integer Noise = 0;
      //Float Pressure = 0.0;

      for (Document doc : result) {
        System.out.println(doc); 
        tem = latest.getDouble("tem").floatValue();
        //    Humidity = latest.getInteger("Humidity");
        CO2 = latest.getInteger("CO2");
        Noise = latest.getInteger("Noise");
        //    Pressure = latest.getDouble("Pressure").floatValue();
      }
      textSize(20);
      text("time :", 550, 75);
      text("temperature : "+tem + "℃", 550, 100);
      //text("Humidity : " + Humidity + "%", 550,125);
      text("CO2 : " + CO2 + "ppm", 550, 150);     
      text("Noise : " + Noise + "dB", 550, 250);     
      // text("Pressure : " +Pressure + "mb", 550,200);

      fnct = 0;
    }
  }

  void mouseReleased() {
    String feeling = null;
    type = "manual";

    stroke(255, 0, 0);
    strokeWeight(5);

    if (mouseY >= 75 && mouseY <= 125) {
      if (mouseX>=750 && mouseX <= 815) {
        feeling = "hot";
        vote.updateResultArea(game.getJankenResult("Gu"));

        tmpTemp = feeling;
        //rect(750, 75, 65, 50);
        //noStroke();
      } else if (mouseX>825 && mouseX <= 890) {
        feeling = "good";
        vote.updateResultArea(game.getJankenResult("Choki"));

        tmpTemp = feeling;
        //rect(825, 75, 65, 50);
        //noStroke();
      } else if (mouseX>905 && mouseX <= 970) {
        feeling = "cold";
        vote.updateResultArea(game.getJankenResult("Pa"));

        tmpTemp =feeling;
      }
      Date date = Calendar.getInstance().getTime();
      colTemp.insertOne(new Document("date", date).append("feeling", feeling).append("user", userName).append("type", type));
    }
    if (mouseY >=150 && mouseY <= 200) {
      if (mouseX >= 750 && mouseX <=850) {
        feeling = "good";
        vote.updateResultArea(game.getJankenResult("Choki"));
        tmpCO2 = feeling;
      } else if (mouseX >= 875 && mouseX <= 975) {
        feeling = "bad";
        vote.updateResultArea(game.getJankenResult("Bad"));
        tmpCO2 = feeling;
      }
      Date date = Calendar.getInstance().getTime();
      colCo2.insertOne(new Document("date", date).append("feeling", feeling).append("user", userName).append("type", type));
    }
    if (mouseY >= 225 && mouseY <= 275) {
      if (mouseX >= 750 && mouseX <=850) {
        feeling = "good";
        vote.updateResultArea(game.getJankenResult("Choki"));
        tmpSound = feeling;
      } else if (mouseX >= 875 && mouseX <= 975) {
        feeling = "bad";
        vote.updateResultArea(game.getJankenResult("Bad"));
        tmpSound = feeling;
      }
      Date date = Calendar.getInstance().getTime();
      colNoise.insertOne(new Document("date", date).append("feeling", feeling).append("user", userName).append("type", type));
    }
    noStroke();
  }



  void dispose() {
    println("run dispose method");
  }
}