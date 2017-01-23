class zoe_main {
  // カンマ区切りテキストファイルの読み込み
  // 最大行列数定義
  int MAX_LINE = 1024;
  int MAX_CUE = 12;

  Tem tem;
  Co2 co2;
  Sound sound;



  // 行データ格納文字列
  String[] datalines;
  List<String> todaylines = new ArrayList<String>();

  SimpleDateFormat sdf1 = new SimpleDateFormat("\"yyyy年MM月dd日HH時mm分\"");

  // データ配列（※0行0列からスタート）
  int[][] data = new int[MAX_LINE][MAX_CUE];
  String[][] data1 = new String[MAX_LINE][0];

  int[] sum = new int[MAX_CUE];

  int[] value1 = new int[11];
  String[] s1 = {"YouTube", "ブラウザ", "メール", "プログラミング", "論文編集", "テキスト閲覧", 
    "プレゼン編集", "うちぞえプログラム", "デスクトップ", "ファイル操作", "登録外"};

  float[] pr = new float[MAX_CUE]; //割合
  float[] min = new float[MAX_CUE]; //分
  float[] sec = new float[MAX_CUE]; //秒

  float w = 850;  //バーの横幅
  float h;
  float graph_x = 25;
  float y;
  float m;
  float all; //sumの合計
  float font1 = 255;
  float font2 = 0;
  float font3 = 255;
  float value_y1 = 450; //タスク表示のY座標（左側）
  float value_y2 = 450; //タスク表示のY座標（右側）
  float value_y3 = 450;

  int hot = 0;
  int cold = 0;
  int good = 0;

  
  int fnct;
  int cnt;  


  String[] s = {"good", "bad", "null"};


  MongoClient mongo = new MongoClient("150.89.234.253", 27018);

  void drawFeelingGraph() {
      String[] datalines;
  List<String> todaylines = new ArrayList<String>();

  SimpleDateFormat sdf1 = new SimpleDateFormat("\"yyyy年MM月dd日HH時mm分\"");

  // データ配列（※0行0列からスタート）
  int[][] data = new int[MAX_LINE][MAX_CUE];
  String[][] data1 = new String[MAX_LINE][0];

  int[] sum = new int[MAX_CUE];

  int[] value1 = new int[11];
  String[] s1 = {"YouTube", "ブラウザ", "メール", "プログラミング", "論文編集", "テキスト閲覧", 
    "プレゼン編集", "うちぞえプログラム", "デスクトップ", "ファイル操作", "登録外"};

  float[] pr = new float[MAX_CUE]; //割合
  float[] min = new float[MAX_CUE]; //分
  float[] sec = new float[MAX_CUE]; //秒

  float w = 850;  //バーの横幅
  float x = graph_x;
  float m;
  float all = 0; //sumの合計
  float font1 = 255;
  float font2 = 0;
  float font3 = 255;
  float value_y1 = 450; //タスク表示のY座標（左側）
  float value_y2 = 450; //タスク表示のY座標（右側）
  float value_y3 = 450;
    database = mongo.getDatabase("test");
    //size(1000, 600);
    //background(255);

    myFont = createFont("MS-Gothic", 12);    //フォント作成
    textFont(myFont, 16);  //テキストのサイズを設定
    textAlign(CENTER);

    tem = new Tem();
    co2 = new Co2();
    sound = new Sound();


    //barW = width / float(value.length);  //バーの横幅を決定
    // ファイル読み込み
    datalines = kawazoeLoadStrings("C:\\logs\\TestUserA\\TaskHistories_Time.csv");
    //datalines.replaceAll(",","");

    // ファイルが開けた場合
    Calendar cal = Calendar.getInstance(); //現在時刻のCalendar
    cal.set(Calendar.HOUR_OF_DAY, 0);
    cal.set(Calendar.MINUTE, 0);
    cal.set(Calendar.SECOND, 0); //時間を全部0にする
    Date now = cal.getTime(); //dateに変換
    for (int k = 0; k < datalines.length; k++) {
      String line = datalines[k];
      Date formatDate = null;
      try {
        formatDate = sdf1.parse(line.split(",")[0]);
      }
      catch(ParseException e0) {
        System.err.println(e0.getMessage());
      }
      if ( formatDate != null && now.compareTo(formatDate) <= 0) {
        todaylines.add(datalines[k]);
      }
      
    } 

    datalines = todaylines.toArray(new String[todaylines.size()]);
    if (datalines != null) {
      for (int i = 1; i < datalines.length; i ++) {
        // 空白行でないかを確認
        if (datalines[i].length() != 0) {
          //System.out.println(datalines[i]);
          // 一行読み取ってカンマ区切りで格納
          String[] values = datalines[i].split(",", -1);
          //System.out.println(values.length);
          // 列の数だけ読み取り
          for (int j = 1; j < MAX_CUE; j ++) {
            values[j] = values[j].replaceAll("\"", "");
            if (values[j] != null && values[j].length() != 0) {
              data[i][j] = int(values[j]);
              // コンソール表示用
              print(data[i][j] + "\t");
            }
          }
          // コンソール表示用
          print("\n");
        }
      }

      for (int a = 1; a < MAX_CUE; a++) {
        for (int b = 1; b < datalines.length; b++) {
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
        if (c <= 4) {
          //fill(font1, 0, font2);
          rect(50, value_y1, 10, 10);
          text(s1[c-1] + "=" + mi + "分" + se + "秒", 180, value_y1 + 10);
          value_y1 = value_y1 + 30;
        } else if (c <= 8) {
          //fill(font1, 255, font3);
          rect(300, value_y2, 10, 10);
          text(s1[c-1] + "=" + mi + "分" + se + "秒", 430, value_y2 + 10);
          value_y2 = value_y2 + 30;
        } else {
          rect(550, value_y3, 10, 10);
          text(s1[c-1] + "=" + mi + "分" + se + "秒", 680, value_y3 + 10);
          value_y3 = value_y3 + 30;
        }
        stroke(0);
        rect(x, y, m, h);
        x = x + m;
        System.out.println(x);
      }
      float minitue = all / 60;
      int time = int(minitue);
      fill(0, 0, 0);
      text(0, 25, 370);
      text(time +"       (分)", 855, 370);
      System.out.println(minitue);
      print("\n");

      print(datalines.length + "行のデータでした");
      System.out.println(now);
    }
    tem.temData();
    co2.co2Data();
    sound.soundData();
  }


  int fcnt;
  void setup() {
    
    drawFeelingGraph(); 
    cnt = 0;
    fcnt = 0;
  }

  
  void draw(){
    /*fill(255);
    textSize(12);
    rect(0, 0, 100, 100);
    fill(0);
    text(String.format("cnt:%d\nfcnt%d", cnt, fcnt), 0, 0, 100, 100);*/
    
    if(cnt >= 60 ){
      fill(256,256,256);
      rect(0,0,450,300);
      fill(0);
      tem.temData();
      co2.co2Data();
      sound.soundData();
      cnt = 0;
    }
    cnt++;
    
    if( fcnt >= 2580){
      //5分に1回やる処理
      fill(256,256,256);
      rect(0,300,1000,300);
      fill(0);
      drawFeelingGraph();
      fcnt = 0;
    }
    fcnt++;
  }  



  void alert() {
    alert.trigger();
  }

  void stop() {
    alert.close();
    minim.stop();
    //super.stop();
  }
}