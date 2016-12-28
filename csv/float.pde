class FloatTable {
  int rowCount;
  int columnCount;
  float[][] data;
  String[] rowNames;
  String[] columnNames;
  
  //コンストラクタ
  //指定されたファイルからタブ区切りのデータを読み込み、取得された値をプロパティに読み込む
  FloatTable(String filename) {
    String[] rows = loadStrings(filename);
    
    String[] columns = split(rows[0], TAB);
    columnNames = subset(columns, 1); //一番左上のラベルは無視
    scrubQuotes(columnNames);
    columnCount = columnNames.length;
 
    rowNames = new String[rows.length-1];
    data = new float[rows.length-1][];
 
    //最初の行はヘッダーなので無視して、次の行から読みこむ
    for (int i = 1; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
    continue; //空白行は無視する
      }
      if (rows[i].startsWith("#")) {
    continue;  //コメント行(#のついた行)は無視する
      }
 
      //タブ区切りでデータを読み込む
      String[] pieces = split(rows[i], TAB);
      //引用符を除去
      scrubQuotes(pieces);
      
      //行のタイトル(最初の列)をコピー
      rowNames[rowCount] = pieces[0];
      //最初の列(タイトル)は無視して、次の列からデータをdata配列にコピー
      data[rowCount] = parseFloat(subset(pieces, 1));
 
      //行のカウントを1つ増加
      rowCount++;      
    }
    //必要であれば、data配列の大きさをリサイズ
    data = (float[][]) subset(data, 0, rowCount);
  }
  
  //データから引用符を除去
  void scrubQuotes(String[] array) {
    for (int i = 0; i < array.length; i++) {
      if (array[i].length() > 2) {
    if (array[i].startsWith("\nquot;") && array[i].endsWith("\nquot;")) {
      array[i] = array[i].substring(1, array[i].length() - 1);
    }
      }
      //ダブルクォートをシングルクォートに
      array[i] = array[i].replaceAll("quot;\nquot;", "\nquot;");
    }
  }
  
  //行の数を数える
  int getRowCount() {
    return rowCount;
  }
  
  //指定した列番号の行の名前を返す
  String getRowName(int rowIndex) {
    return rowNames[rowIndex];
  }
  
  //全ての行の名前を返す
  String[] getRowNames() {
    return rowNames;
  }
 
  
  //行の名前から行番号を返す
  //見つからなかった場合は、-1を返す
  int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {
      if (rowNames[i].equals(name)) {
    return i;
      }
    }
    //println("No row named '" + name + "' was found");
    return -1;
  }
  
  
  //列の数を数える
  int getColumnCount() {
    return columnCount;
  }
  
  //指定した列の名前を返す
  String getColumnName(int colIndex) {
    return columnNames[colIndex];
  }
  
 
  //全ての列の名前を返す
  String[] getColumnNames() {
    return columnNames;
  }
 
 
  //指定した行と列の値をFloat型で返す
  float getFloat(int rowIndex, int col) {
    //異常な値を引数が指定されていた再には、例外処理をしている
    if ((rowIndex < 0) || (rowIndex >= data.length)) {
      throw new RuntimeException("There is no row " + rowIndex);
    }
    if ((col < 0) || (col >= data[rowIndex].length)) {
      throw new RuntimeException("Row " + rowIndex + " does not have a column " + col);
    }
    return data[rowIndex][col];
  }
  
  
  //指定した行と列の値が存在するかどうかを調べる
  boolean isValid(int row, int col) {
    if (row < 0) return false;
    if (row >= rowCount) return false;
    //if (col >= columnCount) return false;
    if (col >= data[row].length) return false;
    if (col < 0) return false;
    return !Float.isNaN(data[row][col]);
  }
 
  //指定した列の最小値を求める
  float getColumnMin(int col) {
    float m = Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      if (isValid(row, col)) {
    if (data[row][col] < m) {
      m = data[row][col];
    }
      }
    }
    return m;
  }
 
  //指定した列の最大値を求める
  float getColumnMax(int col) {
    float m = -Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      if (isValid(row, col)) {
    if (data[row][col] > m) {
      m = data[row][col];
    }
      }
    }
    return m;
  }
 
  //指定した行の最小値を求める
  float getRowMin(int row) {
    float m = Float.MAX_VALUE;
    for (int col = 0; col < columnCount; col++) {
      if (isValid(row, col)) {
    if (data[row][col] < m) {
      m = data[row][col];
    }
      }
    }
    return m;
  } 
 
  //指定した行の最大値を求める
  float getRowMax(int row) {
    float m = -Float.MAX_VALUE;
    for (int col = 0; col < columnCount; col++) {
      if (isValid(row, col)) {
    if (data[row][col] > m) {
      m = data[row][col];
    }
      }
    }
    return m;
  }
 
  //表全体の最小値を求める
  float getTableMin() {
    float m = Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < columnCount; col++) {
    if (isValid(row, col)) {
      if (data[row][col] < m) {
        m = data[row][col];
      }
    }
      }
    }
    return m;
  }
 
  //表全体の最大値を求める
  float getTableMax() {
    float m = -Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < columnCount; col++) {
    if (isValid(row, col)) {
      if (data[row][col] > m) {
        m = data[row][col];
      }
    }
      }
    }
    return m;
  }
}