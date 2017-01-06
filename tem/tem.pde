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

PFont myFont;    //フォント用変数

MongoClient mongo = new MongoClient();
MongoDatabase database = mongo.getDatabase("test") ;
MongoCollection<Document> collection = database.getCollection("feeling-test");

Document latest;
int hot = 0;
int good = 0;
int cold = 0;


void setup(){
  size(1000, 600);
  background(255);
  myFont = createFont("MS-Gothic", 12);    //フォント作成
  textFont(myFont, 12);  //テキストのサイズを設定
  textAlign(CENTER);
  
  FindIterable<Document> result = collection.find();
  
  for(Document doc : result){
    String feeling = doc.getString("feeling");
    if( feeling != null ){
      if( feeling.equals("hot") ){
        hot++;
      }else if( feeling.equals("good") ){
        good++;
      }else if( feeling.equals("cold") ){
        cold++;
      }
    }
  }
    
    System.out.println(hot);
    System.out.println(good);
    System.out.println(cold);
    
}

  
  
  
  
  
  
  
  
  