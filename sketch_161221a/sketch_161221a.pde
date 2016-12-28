float pie_w = 300;  //円グラフの幅
float pie_h = 300;  //円グラフの高さ
int lastAngle = -90;   //通常の円グラフの始点にするため、スタート地点を設定
int[] angle = new int[3];  //グラフの角度
color[] pieColor = new color[angle.length];  //配列angleの項目数分のcolor配列を作成
 
size(400, 400);
background(255);
noStroke();
 
angle[0] = 6;
angle[1] = 3;
angle[2] = 3;

//colorModeをHSBに変更。色相=360°、彩度=100％、明度=100％
colorMode(HSB, 360, 100, 100);
 
for(int i = 0; i < angle.length; i ++){
  pieColor[i] =color(i*40, 100, 100);  //色相のみを40°変えてpiColorに格納
}
 
for (int i = 0; i < angle.length; i ++) {
  fill(pieColor[i]);  //赤
  angle[i] = angle[i] / 12 * 360;
  //中心点のx, 中心点のy, 幅, 高さ, 始点の角度, 終点の角度
  arc(width/2, height/2, pie_w, pie_h, radians(lastAngle), radians(lastAngle + angle[i]));
 
  lastAngle += angle[i];  //lastAngleにangle[i]を足して、次のグラフの開始点にする
}