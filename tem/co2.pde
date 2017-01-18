class Co2 {
  void co2Data(){
  int good = 0;
  int bad = 0;
  
  MongoCollection<Document> collection = database.getCollection("feeling-co2");
  
  Calendar cal = Calendar.getInstance();
  cal.add(Calendar.DATE, -7);
  Date now = cal.getTime();
  
  FindIterable<Document> result = collection.find();
 /* for(Document doc : result){
    Date time = doc.getDate("date");
    String userlist = doc.getString("user");
    String feeling = doc.getString("feeling");
    if( feeling != null){
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
  
  System.out.println("最新情報co2");
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
    fill(127);    //グレーで描画 
    if(value[c] == 0){
      stroke(127);
      line(x + 200, y, x + 230, y);
    }
    if( c == 0 && value[0] >= 0){
      rect(x + 200, y, barW, barH);
      text(value[c], x + 215, y - 10);
    }
    if( c == 1 && value[1] >= 2 ){
      fill(255,0,0);
      rect(x + 200, y, barW, barH);
      text(value[c], x + 215, y - 10);
      alert();
    }else if( c == 1 ){
      rect(x + 200, y, barW, barH);
      text(value[c], x + 215, y - 10);
    }
  }
  fill(127);
  textFont(myFont, 16);
  text("co2", 235, 290);
  Font = createFont("MS-Gothic", 12);
  textFont(Font, 14);
  text("good", 215, 270);
  text("bad", 255, 270);
  //System.out.println(good);
  //System.out.println(bad);
  //Document latest = collection.find(Filters.eq("user", "英知")).sort(Sorts.descending("date")).first();
  //println(latest);
  //println(db.getUserList(collection));
  }
  
}