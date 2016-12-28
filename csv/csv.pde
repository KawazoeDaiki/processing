PFont myFont;    //フォント用変数
int[] value = {10, 14, 20, 80, 2, 18};
String[] s = {"taskpit", "ブラウザ", "メール", "プログラミング", "デバッグ", "テキスト閲覧",
              "プレゼン編集","データ分析","デスクトップ","ファイル操作","登録外"};
 
float barW;  //バーの横幅
float barH;
float resize = 4.0; 
 
size(400, 400);
background(255);
 
myFont = createFont("Arial", 12);    //フォント作成
textFont(myFont, 12);  //テキストのサイズを設定
textAlign(CENTER);
 
barW = width / float(value.length);  //バーの横幅を決定
 
//バーとテキストを描画
for (int i = 0; i < value.length; i ++) {  //value.lenghは配列の要素数を返す
 
  //バーのx座標, y座標を計算
  float x = barW * i;
  float y = height - value[i] * resize;
  barH = value[i] * resize;
 
  fill(127);    //グレーで描画
  rect(x, y, barW, barH);
 
  //テキスト表示
  fill(255, 0, 0);    //赤で描画
  text(s[i] + " = " + value[i], x + barW/2, y - 10);
}