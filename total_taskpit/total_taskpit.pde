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
float[] min = new float[MAX_CUE]; //分
float[] sec = new float[MAX_CUE]; //秒

float w = 850;  //バーの横幅
float h;
float x = 25;
float y;
float m;
float all; //sumの合計
float font1 = 255;
float font2 = 0;
float font3 = 255;
float value_y1 = 450; //タスク表示のY座標（左側）
float value_y2 = 450; //タスク表示のY座標（右側）
float value_y3 = 450;
 
void setup() {
  size(1000, 600);
  background(255);
  myFont = createFont("MS-Gothic", 12);    //フォント作成
  textFont(myFont, 16);  //テキストのサイズを設定
  textAlign(CENTER);
  
  //barW = width / float(value.length);  //バーの横幅を決定
  // ファイル読み込み
  datalines = loadStrings("C:\\Users\\pattsuan\\Desktop\\taskpit-logs\\kawazeo\\TaskHistories_Time.csv");
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
      float y = 380;
      float h = 50;
      
      pr[c] = sum[c] / all;
      //System.out.println(pr[c]);
      min[c] = sum[c] / 60;
      int mi = int(min[c]);
      sec[c] = sum[c] % 60;
      int se = int(sec[c]);
      m = pr[c] * 800;
      System.out.println(m);
      font1 = font1 - 15;
      font2 = font2 + 15;
      font3 = font3 - 15;
      fill(font1, 200, font2);
      if(c <= 4){
        //fill(font1, 0, font2);
        rect(50, value_y1, 10, 10);
        text(s[c-1] + "=" + mi + "分" + se + "秒", 180, value_y1 + 10);
        value_y1 = value_y1 + 30;
      }else if(c <= 8){
        //fill(font1, 255, font3);
        rect(300, value_y2, 10, 10);
        text(s[c-1] + "=" + mi + "分" + se + "秒", 430, value_y2 + 10);
        value_y2 = value_y2 + 30;
      }else{
        rect(550, value_y3, 10, 10);
        text(s[c-1] + "=" + mi + "分" + se + "秒", 680, value_y3 + 10);
        value_y3 = value_y3 + 30;
      }
      rect(x, y, m, h);
      x = x + m;
      System.out.println(x);
    }
    float minitue = all / 60;
    int time = int(minitue);
    fill(0, 0, 0);
    text(0, 25, 370);
    text(time +"       (分)" , 855, 370);
    System.out.println(minitue);
    print("\n");
    
  print(datalines.length + "行のデータでした");
}
}