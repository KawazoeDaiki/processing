class Sound {
  void soundData(){
  int good = 0;
  int bad = 0;
  
  MongoCollection<Document> collection = database.getCollection("feeling-sound");
  
  Calendar cal = Calendar.getInstance();
  cal.add(Calendar.MINUTE, -60);
  Date now = cal.getTime();
  
  FindIterable<Document> result = collection.find();
 /* for(Document doc : result){
    Date time = doc.getDate("date");
    String userlist = doc.getString("user");
    String feeling = doc.getString("feeling");
    if( feeling != null ){
      int diff = now.compareTo(time);
      if(diff <= 0){
      if( feeling.equals("bad") == true && userlist != null){
        bad++;
      }else if( feeling.equals("good") == true || userlist == null){
        good++;
      }
    }
    //System.out.println(doc.toJson());
  }
  }*/
  
  System.out.println("最新情報sound");
  AggregateIterable<Document> lst = db.getUserLatestFeeling(collection, now);
  for(Document doc : lst){
    String user = doc.getString("_id");
    String feeling = doc.getString("last_feeling");
    
    if( feeling != null ){
      if( feeling.equals("good") == true ){
        good++;
      }else if( feeling.equals("bad") == true ){
        bad++;
      }
    }
    System.out.println(user + "くん: " + feeling);
  }
  
  value[0] = good;
  value[1] = bad;
  
  for (int c = 0; c < 2; c ++) {  //value.lenghは配列の要素数を返す 
    //バーのx座標, y座標を計算
    float x = (barW + space) * c;
    float y = 250 - value[c] * resize;
    float y2 = height - 10;
    barH = value[c] * resize; 
      
    noStroke();
    strokeWeight(1);
    fill(127);    //グレーで描画  
    textSize(16);
    if(value[c] == 0){
      stroke(127);
      line(x + 310, y, x + 340, y);
    }   
    if( c == 0 && value[0] >= 0){
      rect(x + 310, y, barW, barH);
      text(value[c], x + 325, y - 10);
    }
    if( c == 1 && value[1] >= 5 ){
      fill(255,0,0);
      rect(x + 310, y, barW, barH);
      text(value[c], x + 325, y - 10);
      alert();
    }else if( c == 1 ){
      rect(x + 310, y, barW, barH);
      text(value[c], x + 325, y - 10);
    }
  }
  
  fill(127);
  textFont(myFont, 16);
  text("sound", 345, 290);
  Font = createFont("MS-Gothic", 12);
  textFont(Font, 14);
  text("good", 325, 270);
  text("bad", 365, 270);
  }
}