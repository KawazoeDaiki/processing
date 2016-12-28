
//データ保存用
float[] x, y;
float xMin = 10000.0;
float xMax = 0.0;
float yMin = 100000.0;
float yMax = 0.0;

//描画用
float plotX1, plotY1, plotX2, plotY2;
float dataAreaWidth, dataAreaHeight;
float labelX, labelY;
PFont plotFont;
float xgMin = 20.0;
float xgMax = 40.0;
float xInterval = 5.0;
float ygMin = 5.0;
float ygMax = 20.0;
float yInterval = 5.0;

//データの数
int lmax;
int imax = 0;

void setup() {
//csvファイルからのデータ読み込み  
  String[] lines = loadStrings("chugoku2010s.csv");
  lmax = lines.length;
  
//Initialization
  x = new float[lmax];
  y = new float[lmax];
  
//データの読み込み
  for(int l = 0; l < lmax; l++) {
    String[] tokens = splitTokens(lines[l], ",");
    if(int(tokens[1]) != 1 && int(tokens[1]) != 7) {  //平日のデータのみ取り出す
      x[imax] = float(tokens[2]);
      y[imax] = float(tokens[3]) / 100.0;
//最大値・最小値の記憶    
      if (x[imax] > xMax) {
        xMax = x[imax];
      }
      if (x[imax] < xMin) {
        xMin = x[imax];
      }
      if (y[imax] > yMax) {
        yMax = y[imax];
      }
      if (y[imax] < yMin) {
        yMin = y[imax];
      }
      imax = imax + 1;
    }
  }
  
  size(600, 400);
  
  plotFont = createFont("SansSerif", 20);
   
  plotX1 = 100;
  plotY1 = 80;
  plotX2 = width - plotX1 / 2;
  plotY2 = height - plotY1;
  dataAreaWidth = plotX2 - plotX1;
  dataAreaHeight = plotY2 - plotY1;
  labelX = plotX1;
  labelY = plotY2 + 40;
  
  textFont(plotFont);
}

void draw(){
  background(255);
  
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(1);
  smooth();
  rectMode(CORNERS);
  rect(plotX1, plotY1, plotX2, plotY2);
  
  drawTitleLabel();
  drawAxisLabels();
  drawXGrid();
  drawYGrid();
  
  drawDataPoints();
  ols();
}

void drawDataPoints() {
  for(int i = 0; i < imax; i++) {
    float xx = map(x[i], xgMin, xgMax, plotX1, plotX2);
    float yy = map(y[i], ygMin, ygMax, plotY2, plotY1);
    stroke(0,0,255);
    strokeWeight(1);
    noFill();
    ellipse(xx, yy, 6, 6);
  }
}

void drawTitleLabel( ) {
  fill(0);
  textSize(16);
  textAlign(CENTER,CENTER);
  text("Chugoku Electric Power Co.",(plotX1 + plotX2) / 2, plotY1 - 40);
}

void drawAxisLabels() {
  fill(0);
  textSize(12);
  textLeading(15);
  textAlign(CENTER, CENTER);
  text("Max. Electricity\n[GW]", labelX, plotY1 - 30);
  textAlign(CENTER);
  text("Daily Max. Air Temperature in Hiroshima [C]", (plotX1 + plotX2) / 2, labelY);
}

void drawXGrid(){
  fill(0);
  strokeWeight(1);
  textSize(12);
  textAlign(CENTER, TOP);
  
  float x1 = xgMin;
  while(x1 < xgMax) {
    float x2 = map(x1, xgMin, xgMax, plotX1, plotX2);
    text(int(x1), x2, plotY2 + 10);
    line(x2, plotY2, x2, plotY1);
    x1 = x1 + xInterval;
  }
  float x2 = map(xgMax, xgMin, xgMax, plotX1, plotX2);
  text(int(xgMax), x2, plotY2 + 10);
}

void drawYGrid(){
  fill(0);
  strokeWeight(1);
  textSize(12);
  textAlign(RIGHT, CENTER);
  
  float y1 = ygMin;
  while(y1 < ygMax) {
    float y2 = map(y1, ygMin, ygMax, plotY2, plotY1);
    text(int(y1), plotX1 - 10, y2);
    line(plotX1, y2, plotX2, y2);
    y1 = y1 + yInterval;
  }
  float y2 = map(ygMax, ygMin, ygMax, plotY2, plotY1);
  text(int(ygMax), plotX1 - 10, y2);
}

void ols() {  
  float avx = 0.0;
  float avy = 0.0;  
  float sstx = 0.0;
  float ssty = 0.0;
  float sstxy = 0.0;
  float alp, bt;

//平均値の算出  
  for(int i = 0; i < imax; i++) {
    avx = avx + x[i];
    avy = avy + y[i];
  }
  avx = avx / imax;
  avy = avy / imax;
  
//
  for(int i = 0; i < imax; i++) {
    sstx = sstx + (x[i] - avx) * (x[i] - avx);
    ssty = ssty + (y[i] - avy) * (y[i] - avy);
    sstxy = sstxy + (x[i] - avx) * (y[i] - avy);
  }

//傾きと切片の算出  
  bt = sstxy / sstx;
  alp = avy - bt * avx;

//回帰直線を引く  
  float x1 = map(xMin, xgMin, xgMax, plotX1, plotX2);
  float x2 = map(xMax, xgMin, xgMax, plotX1, plotX2);
  float y1 = alp + bt * xMin;
  float y2 = alp + bt * xMax;
  y1 = map(y1, ygMin, ygMax, plotY2, plotY1);
  y2 = map(y2, ygMin, ygMax, plotY2, plotY1);
  stroke(0, 0, 255);  
  strokeWeight(3);
  line(x1, y1, x2, y2);
  
//回帰式を書く
  /*fill(0, 0, 255);
  textSize(12);
  textAlign(LEFT, CENTER);
  text("Y = " + alp + " + " + bt + " * X", x1, y1 + 10);*/
}