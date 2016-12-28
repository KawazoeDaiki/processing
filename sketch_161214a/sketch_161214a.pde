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
int[] value = new int[MAX_CUE];
String[] s = {"taskpit", "ブラウザ", "メール", "プログラミング", "デバッグ", "テキスト閲覧",
              "プレゼン編集","データ分析","デスクトップ","ファイル操作","登録外"};
              
float barW;  //バーの横幅
float barH;
float resize = 4.0; 
 
void draw() {
  graph.update();
  barW = width / float(value.length);  //バーの横幅を決定
  // ファイル読み込み
  datalines = loadStrings("TaskHistories_Time.csv");
  // ファイルが開けた場合
  if(datalines != null) {
  for(int i = 1; i < datalines.length; i ++) {
    // 空白行でないかを確認
    if(datalines[i].length() != 0) {
      //System.out.println(datalines[i]);
      // 一行読み取ってカンマ区切りで格納
      String[] values = datalines[i].split("\",\"" , -1);
      // 列の数だけ読み取り
      for(int j = 1; j < MAX_CUE; j ++) {
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
      for (int c = 0; c < value.length; c ++) {  //value.lenghは配列の要素数を返す
        value[c] = sum[a];
        //バーのx座標, y座標を計算
        float x = barW * c;
        float y = height - value[c] * resize;
        barH = value[c] * resize;
        fill(127);    //グレーで描画
        rect(x, y, barW, barH);
 
        //テキスト表示
        fill(255, 0, 0);    //赤で描画
        text(s[c] + " = " + value[c], x + barW/2, y - 10);
      }
    }
    print("\n");
  print(datalines.length + "行のデータでした");
}
}