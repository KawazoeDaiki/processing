class Mongo{
  void mongo(){
    
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
  }
}