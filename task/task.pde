// カンマ区切りテキストファイルの読み込み
// 最大行列数定義
int MAX_LINE = 1024;
int MAX_CUE = 12;


// 行データ格納文字列
String[] datalines;

// データ配列（※0行0列からスタート）
int[][] data = new int[MAX_LINE][MAX_CUE];
//String[][] data1 = new String[MAX_LINE][0];

int[] sum = new int[MAX_CUE];

PFont myFont;    //フォント用変数
int[] value = new int[11];
String[] s = {"taskpit", "ブラウザ", "メール", "プログラミング", "デバッグ", "テキスト閲覧",
              "プレゼン編集","データ分析","デスクトップ","ファイル操作","登録外"};
              
float barW = 40;  //バーの横幅
float barH;
float x;
float y;
float resize = 3.0; 
float space = 30.0;
float margin = 20.0;
 
void setup() {
  size(850, 500);
  background(255);
  myFont = createFont("MS-Gothic", 12);    //フォント作成
  textFont(myFont, 12);  //テキストのサイズを設定
  textAlign(CENTER);
  
  //barW = width / float(value.length);  //バーの横幅を決定
  // ファイル読み込み
  datalines = loadStrings("Book2.csv");
  //datalines.replaceAll(",","");
  // ファイルが開けた場合
  if(datalines != null) {
  for(int i = 1; i < datalines.length; i ++) {
    // 空白行でないかを確認
    if(datalines[i].length() != 0) {
      //System.out.println(datalines[i]);
      // 一行読み取ってカンマ区切りで格納
      String[] values = datalines[i].split("," , -1);
      //System.out.println(values.length);
      // 列の数だけ読み取り
      for(int j = 1; j < MAX_CUE; j ++) {
        values[j] = values[j].replaceAll("\"", "");
        if(values[j] != null && values[j].length() != 0) {
          data[i][j] = int(values[j]);
            // コンソール表示用
            print(data[i][j] + "\t");
        }
      }
      // コンソール表示用
      print("\n");
    }
  }
    for(int a = 1; a < MAX_CUE; a++){
      for(int b = 1; b < datalines.length; b++){
        sum[a] += data[b][a];  
      }
      print(sum[a] + "\t");
      }
    for (int c = 0; c < value.length; c ++) {  //value.lenghは配列の要素数を返す
      value[c] = sum[c+1];
      //バーのx座標, y座標を計算
      float x = (barW + space) * c + margin;
      float y = height - value[c] / 60.0 * resize - margin;
      float y2 = height - 10;
      barH = value[c] / 60.0 * resize; 
      
      if(c == 0){
        fill(0, 0, 0); //なんかしらんけど動く
        line(45, y2-10, width, y2-10); text("0",35, y2-5);
        line(45, y2-70, width, y2-70); text("20",35, y2-65);
        line(45, y2-130, width, y2-130); text("40",35, y2-125);
        line(45, y2-190, width, y2-190); text("60",35, y2-185);
        line(45, y2-250, width, y2-250); text("80",35, y2-245);
        line(45, y2-310, width, y2-310); text("100",35, y2-305);
        line(45, y2-370, width, y2-370); text("120",35, y2-365);
        line(45, y2-430, width, y2-430); text("150",35, y2-425);
        //line(45, y2-490, width, y2-490); text("180",35, y2-485);
        line(50, y2-5, 50, y2-435);
        text("分", 45, 30);
      }
      //println(barH);
      noStroke();
      fill(127);    //グレーで描画
      if(value[c] >= 7200){
        fill(255, 0, 0);
      }
      rect(x + 50, y, barW, barH);
      //テキスト表示
      fill(255, 0, 0);    //赤で描画
      text(s[c] , x + barW/2 + 50, y2);
     /* if(c == 0){
        line(45, y2-10, width, y2-10); text("0",35, y2-5);
        line(45, y2-70, width, y2-70); text("20",35, y2-65);
        line(45, y2-130, width, y2-130); text("40",35, y2-125);
        line(45, y2-190, width, y2-190); text("60",35, y2-185);
        line(45, y2-250, width, y2-250); text("80",35, y2-245);
        line(45, y2-310, width, y2-310); text("100",35, y2-305);
        line(45, y2-370, width, y2-370); text("120",35, y2-365);
        line(45, y2-430, width, y2-430); text("150",35, y2-425);
        //line(45, y2-490, width, y2-490); text("180",35, y2-485);
        line(50, y2-5, 50, y2-435);
        text("分", 45, 30);
      }*/
    }
    print("\n");
    
  print(datalines.length + "行のデータでした");
}
}