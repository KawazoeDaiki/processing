public String[] kawazoeLoadStrings(String filepath){
  System.out.println("Kawazoe Load String called.");
  
  List<String> strings = new ArrayList<String>();
  
  try {
    //File file = new File("C:\\Users\\pattsuan\\Desktop\\taskpit-logs\\kawazeo\\TaskHistories_Time.csv");
    File file = new File(filepath);
    FileInputStream input = new FileInputStream(file);  
    InputStreamReader stream = new InputStreamReader(input,"SJIS");
    BufferedReader buffer = new BufferedReader(stream);
        
    String line;
             
    while ((line = buffer.readLine()) != null) {
      System.out.println(line);
      //byte[] b = line.getBytes();
      //line = new String(b, "UTF-8");
      strings.add(line);
    }
      
    input.close();
    stream.close();
    buffer.close();
  
  } catch (IOException e) {
    e.printStackTrace();
  }
  
  return strings.toArray(new String[strings.size()]);
}