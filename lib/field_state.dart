class FieldState {
  bool isAttacked = false;
  bool hasQueen = false;

  bool get canSetQueen => !isAttacked && !hasQueen;
}