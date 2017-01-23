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
import java.text.*;
import java.io.*;

int[] value = new int[3];
float barW = 30;  //バーの横幅
float barH;
float resize = 10.0; 
float space = 10.0;

PFont myFont;    //フォント用変数
PFont Font;

  /*音*/
Minim minim;
AudioSample alert;

MongoDatabase database;

zoe_main zm = new zoe_main();
uchi_main um = new uchi_main();

void setup(){
  size(1000, 600);
  minim = new Minim( this );
  alert = minim.loadSample("18am02.wav");
  zm.setup();
  um.setup();
}

void draw(){ 
  um.draw();
  zm.draw();
}

void alert(){
  alert.trigger();
}

void mouseReleased(){
  um.mouseReleased();
}

void dispose(){
  um.dispose();
}

void stop(){
  zm.stop();
}