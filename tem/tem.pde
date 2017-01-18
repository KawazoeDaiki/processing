import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import com.mongodb.*;
import com.mongodb.annotations.*;
import com.mongodb.assertions.*;
import com.mongodb.async.*;
import com.mongodb.binding.*;
import com.mongodb.bulk.*;
import com.mongodb.client.*;
import com.mongodb.client.gridfs.*;
import com.mongodb.client.gridfs.codecs.*;
import com.mongodb.client.gridfs.model.*;
import com.mongodb.client.model.*;
import com.mongodb.client.model.geojson.*;
import com.mongodb.client.model.geojson.codecs.*;
import com.mongodb.client.result.*;
import com.mongodb.connection.*;
import com.mongodb.connection.netty.*;
import com.mongodb.diagnostics.logging.*;
import com.mongodb.event.*;
import com.mongodb.gridfs.*;
import com.mongodb.internal.*;
import com.mongodb.internal.async.*;
import com.mongodb.internal.authentication.*;
import com.mongodb.internal.connection.*;
import com.mongodb.internal.management.jmx.*;
import com.mongodb.internal.thread.*;
import com.mongodb.internal.validator.*;
import com.mongodb.management.*;
import com.mongodb.operation.*;
import com.mongodb.selector.*;
import com.mongodb.util.*;
import org.bson.*;
import org.bson.assertions.*;
import org.bson.codecs.*;
import org.bson.codecs.configuration.*;
import org.bson.conversions.*;
import org.bson.diagnostics.*;
import org.bson.io.*;
import org.bson.json.*;
import org.bson.types.*;
import org.bson.util.*;

import java.util.*;

/*音*/
Minim minim;
AudioSample alert;

Co2 co2;
Sound sound;
//db db;

PFont myFont;    //フォント用変数
PFont Font;

int hot = 0;
int cold = 0;
int good = 0;

int[] value = new int[3];
String[] s = {"good","bad","null"};

float barW = 30;  //バーの横幅
float barH;
float resize = 10.0; 
float space = 10.0;

MongoClient mongo = new MongoClient("150.89.234.253", 27018);
MongoDatabase database = mongo.getDatabase("test") ;
MongoCollection<Document> collection = database.getCollection("feeling-temperature");

void setup(){
  size(1000, 600);
  background(255);
  minim = new Minim( this );
  alert = minim.loadSample("18am02.wav");
  myFont = createFont("MS-Gothic", 12);    //フォント作成
  textFont(myFont, 16);  //テキストのサイズを設定
  textAlign(CENTER);
  
  co2 = new Co2();
  sound = new Sound();
  //db = new db();
  
  Calendar cal = Calendar.getInstance();
  cal.add(Calendar.DATE, -7);
  Date now = cal.getTime();
  
  FindIterable<Document> result = collection.find();
 /* for(Document doc : result){
    Date time = doc.getDate("date");
    String userlist = doc.getString("user");
    String feeling = doc.getString("feeling");
    
    if( feeling != null ){
      int diff = now.compareTo(time);
      if(diff <= 0){
      if( feeling.equals("hot") == true && userlist != null){
        hot++;
      }else if( feeling.equals("cold") == true && userlist != null){
        cold++;
      }else if( feeling.equals("good") == true || userlist == null){
        good++;
      }
    }
    System.out.println(doc.toJson());
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
  line(0,300,1000,300);
  for (int c = 0; c < value.length; c ++) {  //value.lenghは配列の要素数を返す 
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
    if( c == 1 && value[1] >= 2 ){
      fill(255,0,0);
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
      alert();
    }else if( c == 1 ){
      rect(x + 50, y, barW, barH);
      text(value[c], x + 65, y - 10);
    }
    if( c == 2 && value[2] >= 2 ){
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
  
    System.out.println("HOT : " + hot);
    System.out.println("COLD: " + cold);
    System.out.println("GOOD: " + good);  
    
    co2.co2Data();
    sound.soundData();
    
    System.out.println(now);
}  

void draw(){
}

void alert(){
  alert.trigger();
}

void stop(){
  alert.close();
  minim.stop();
  super.stop();
}
  
  
  
  
  
  
  
  