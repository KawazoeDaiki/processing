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



      
MongoClient mongo;
MongoCollection<Document> collection;
Board board;
Game game;
void setup() {
  
        //MongoDBサーバーに接続
      mongo = new MongoClient("150.89.234.253", 27018);
      //利用するデータベースを取得
      MongoDatabase database = mongo.getDatabase("feeling");
      //利用するコレクション名(テーブル)を指定
      collection = database.getCollection("feeling-test");
  
      for(Document doc : collection.find()){
        System.out.println(doc.toJson());
      }
      

  
  surface.setSize(600, 300);
  board = new Board();
  game = new Game();
  background(0);
}

void draw() {
  board.updateSelectArea();
  board.updateCommentArea("Choose Your Physical Condition");
  
}

void mouseReleased() {
  String feeling = null;
  
  if (mouseX>=0 && mouseX <= 200 && mouseY >=0 && mouseY <= 150) {
    feeling = "hot";
    board.updateResultArea(game.getJankenResult("Gu"));
  } else if (mouseX>200 && mouseX <= 400 && mouseY >=0 && mouseY <= 150) {
    feeling = "cold";
    board.updateResultArea(game.getJankenResult("Choki"));
  } else if (mouseX>400 && mouseX <= 600 && mouseY >=0 && mouseY <= 150) {
   feeling = "good";
    board.updateResultArea(game.getJankenResult("Pa"));
  }
  String date = year() + "-" + month () + "-" + day() + "-" + hour() + "-" + minute() + "-" + second();
  collection.insertOne(new Document("date", date).append("feeling",feeling));
}

void dispose(){
  println("exit");
  mongo.close();
}
  