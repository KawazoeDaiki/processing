static class db {
  //指定したコレクションから、登録されているユーザーの配列を取得する
  public static List<String> getUserList(MongoCollection<Document> col){
    List<String> users = new ArrayList<String>();
    List<Bson> query = Arrays.asList(Aggregates.group("$user"));
    
    for(Document doc : col.aggregate(query)){
      String name = doc.getString("_id");
      if( name != null ){
        users.add(name);
        //System.out.println(name);
      }
    }
    
    return users;
  }
  
  public static AggregateIterable<Document> getUserLatestFeeling(MongoCollection<Document> col, Date since){
    List<Bson> query = Arrays.asList(
      Aggregates.match(Filters.gte("date", since)),
      Aggregates.sort(Sorts.descending("date")),
      Aggregates.group("$user", Arrays.asList(
        Accumulators.first("last_feeling", "$feeling")))
    );
    
    return col.aggregate(query);
  }
}