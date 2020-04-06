import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'autofocus_directive.dart';
import 'sudoku_util.dart';

@Component(
  selector: 'board',
  templateUrl: 'board_component.html',
  directives: [coreDirectives, formDirectives, AutofocusDirective],
  styleUrls: ['board_component.css'],
  providers: [ClassProvider(SudokuUtil)],
)
class BoardComponent {
  final _ESCAPE_KEY = 27;
  List fields;
  int activeRow;
  int activeCol;
  bool solved = false;
  SudokuUtil _utility;
  final RegExp pattern = RegExp("[1-9]");
  String message;

  BoardComponent(this._utility) {
    _generateEmptyFields();
  }

  void clearBoard() {
    _generateEmptyFields();
    message = null;
  }

  bool isActive(int r, int c) {
    return activeRow == r && activeCol == c;
  }

  void onKey(dynamic evt) {
    if (evt.keyCode == _ESCAPE_KEY) {
      _clearSelection();
    }
  }

  void setActive(int r, int c) {
    activeRow = r;
    activeCol = c;
  }

  void setFieldValue(int r, int c, dynamic value) {
    if (pattern.hasMatch(value)) {
      fields[r][c] = int.parse(value);
    }
  }

  void solve([ int r = 0, int c = 0 ]) {
    bool valid = _validateUserInput();
    if (!valid) {
      message = 'Can\'t solve this sudoku.';
    } else {
      bool res = _utility.solve(fields, r, c);
      if (res) {
        message = 'Success';
      } else {
        message = 'Can\'t solve this sudoku.';
      }
    }
  }

  void _clearSelection() {
    activeRow = null;
    activeCol = null;
  }

  void _generateEmptyFields() {
    fields = List.generate(9, (_) => List(9));
  }

  bool _validateUserInput() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (fields[r][c] != null && !_utility.checkField(fields, r, c, fields[r][c])) {
          return false;
        }
      }
    }
    return true;
  }
}