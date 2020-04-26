import 'dart:math';

import 'package:eightqueenspuzzle/field_state.dart';

Random r = Random();

List<List<FieldState>> generateEmptyFields(int size) {
  return List<List<FieldState>>.generate(size, (_) => List<FieldState>.generate(size, (_) => FieldState()));
}

Future<List<List<FieldState>>> calculateQueensPositions(int size) async {
  var fields = generateEmptyFields(size);

  while (true) {
    bool success = true;
    for(var i = 0; i < size; i++) {
      if (haveFreeField(fields[i])) {
        final row = fields[i].where((r) => r.canSetQueen).toList();
        row[r.nextInt(row.length)].hasQueen = true;
        final indexOfQueen = getIndex(fields[i]);
        setAttackedFields(fields, i, indexOfQueen);
      } else {
        i = size;
        fields = generateEmptyFields(size);
        success = false;
      }
    }
    if (success) break;
  }
  return fields;
}

void setAttackedFields(List<List<FieldState>> fields, int x, int y) {
  int l = fields.length;
  for (var i = 0; i < l; i++) {
    fields[i][y].isAttacked = true;
    fields[x][i].isAttacked = true;
    if (x + i < l && y + i < l) fields[x + i][y + i].isAttacked = true;
    if (x + i < l && y - i >= 0) fields[x + i][y - i].isAttacked = true;
    if (x - i >= 0 && y - i >= 0) fields[x - i][y - i].isAttacked = true;
    if (x - i >= 0 && y + i < l) fields[x - i][y + i].isAttacked = true;
  }
}

int getIndex(List<FieldState> row) {
  for(var i = 0; i < row.length; i++) {
    if(row[i].hasQueen) return i;
  }
  return null;
}

bool haveFreeField(List<FieldState> row) => row
    .map((r) => r.canSetQueen)
    .toList()
    .reduce((a, b) => a || b);