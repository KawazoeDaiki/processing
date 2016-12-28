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

float[] pr = new float[MAX_CUE]; //割合

float w = 850;  //バーの横幅
float h;
float x;
float y;
float all; //sumの合計
float font = 0; 
 
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
      all += sum[a];
      }
      System.out.println(all);
    for (int c = 1; c < pr.length; c ++) {  //value.lenghは配列の要素数を返す
      float x = 25;
      float y = 25;
      float w = 0;
      float h = 100;
      
      pr[c] = sum[c+1] / all;
      System.out.println(pr[c]);
      w = pr[c] * 800;
      fill(255, font + 15, 0);
      rect(x + w, y, w, h);
      System.out.println(w);
    }
    
    print("\n");
    
  print(datalines.length + "行のデータでした");
}
}