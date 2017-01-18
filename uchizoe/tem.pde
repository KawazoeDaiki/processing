class Tem {
  void temData(){
    int hot = 0;
    int good = 0;
    int cold = 0;
      
    MongoCollection<Document> collection = database.getCollection("feeling-temperature");
    
  Calendar cal = Calendar.getInstance();
  cal.add(Calendar.MINUTE, -60);
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
  
  System.out.println("最新情報temperature");
  AggregateIterable<Document> lst = db.getUserLatestFeeling(collection, now);
  for(Document doc : lst){
    String user = doc.getString("_id");
    String feeling = doc.getString("last_feeling");
    
    if( feeling != null ){
      if( feeling.equals("hot") == true ){
        hot++;
      }else if( feeling.equals("cold") == true ){
        cold++;
      }else if( feeling.equals("good") == true ){
        good++;
      }
    }
    System.out.println(user + "くん: " + feeling);
  }  
  
  value[0] = good;
  value[1] = hot;
  value[2] = cold;
  
  for (int c = 0; c < 3; c ++) {  //value.lenghは配列の要素数を返す 
    //バーのx座標, y座標を計算
    float x = (barW + space) * c;
    float y = 250 - value[c] * resize;
    float y2 = height - 10;
    barH = value[c] * resize; 
      
    noStroke();
    fill(127);    //グレーで描画 
    if(value[c] == 0){
      stroke(127);
      line(x + 50, y, x + 80, y);
    }

    if( c == 0 && value[0] >= 0){
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
    }
    if( c == 1 && value[1] >= 5 ){
      fill(255,0,0);
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
      alert();
    }else if( c == 1 ){
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
    }
    if( c == 2 && value[2] >= 5 ){
      fill(255,0,0);
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
      alert();
    }else if( c == 2 ){
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
    }

  }
  fill(127);
  text("temperature", 105, 290);
  Font = createFont("MS-Gothic", 12);
  textFont(Font, 14);

  text("good", 64, 270);
  text("hot", 104, 270);
  text("cold", 145, 270);
  //System.out.println(good);
  //System.out.println(bad);
  //Document latest = collection.find(Filters.eq("user", "英知")).sort(Sorts.descending("date")).first();
  //println(latest);
  //println(db.getUserList(collection));
  }
  
} 