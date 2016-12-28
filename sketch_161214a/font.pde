class Graph{
  
  void updateFont(){
    size(400, 400);
    background(255);
    myFont = createFont("Arial", 12);    //フォント作成
    textFont(myFont, 12);  //テキストのサイズを設定
    textAlign(CENTER);
  }
}