class SudokuUtil {
  bool solve(List fields, int r, int c) {
    if (c == 9) {
      r = r+1;
      c = 0;
    }
    if (r == 9) {
      return true;
    }
    var currValue = fields[r][c];
    if (currValue == null) {
      for (int i = 1; i <= 9; i++) {
        if (checkField(fields, r, c, i)) {
          fields[r][c] = i;
          bool canSolve = solve(fields, r, c+1);
          if (canSolve) {
            return true;
          } else {
            fields[r][c] = null;
          }
        }
      }
      return false;
    } else {
      return solve(fields, r, c + 1);
    }
  }

  bool checkField(List matrix, int r, int c, int num) {
    bool row = _checkRow(matrix[r], c, num);
    bool col = _checkColumn(matrix, r, c, num);
    bool box = _checkBox(matrix, r, c, num);
    return row && col && box;
  }

  bool _checkRow(List row, int col, int num) {
    for (int i = 0; i < 9; i++) {
      if (row[i] != null && i != col && row[i] == num) return false;
    }
    return true;
  }

  bool _checkColumn(List matrix, int row, int col, int num) {
    for (int r = 0; r < 9; r++) {
      if (matrix[r][col] != null && r != row && matrix[r][col] == num) return false;
    }
    return true;
  }

  bool _checkBox(List matrix, int r, int c, int num) {
    int boxRow = (r/3).floor();
    int boxCol = (c/3).floor();
    for (int row = boxRow*3; row < (boxRow + 1)*3; row++) {
      for (int col = boxCol*3; col < (boxCol + 1)*3; col++) {
        if (matrix[row][col] != null && row != r && col != c && matrix[row][col] == num) return false;
      }
    }
    return true;
  }
}