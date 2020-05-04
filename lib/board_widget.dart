import 'dart:math';

import 'package:eightqueenspuzzle/calculate_queens_position.dart';
import 'package:eightqueenspuzzle/field_state.dart';
import 'package:eightqueenspuzzle/queen_position.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final int size;
  final void Function(List<QueenPosition>) onQueenSelected;

  Board(this.size, this.onQueenSelected, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => BoardState();
}

class BoardState extends State<Board> {
  List<List<FieldState>> fields = [];
  Random _random = Random();

  double get itemSize => MediaQuery.of(context).size.width / widget.size;

  @override
  void initState() {
    super.initState();
    initBoard();
  }

  @override
  void didUpdateWidget(Board oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.size != widget.size) {
      initBoard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(widget.size, (rowIndex) {
        bool isFirstWhite = rowIndex % 2 == 0;
        return Row(
          children: List<Widget>.generate(widget.size, (index) {
            bool isWhite = isFirstWhite ? index % 2 == 0 : index % 2 == 1;
            return getField(isWhite ? Colors.orangeAccent.withOpacity(0.5) : Colors.brown);
          }),
        );
      }),
    );
  }



  Widget getField(Color color) => Container(
    height: itemSize,
    width: itemSize,
    alignment: Alignment.center,
    color: color,
  );

  initBoard() {
    fields = List<List<FieldState>>.generate(widget.size, (_) => List<FieldState>.generate(widget.size, (_) => FieldState()));
    calculateQueensPositions(widget.size).then((result) {
      setState(() {
        fields = result;
      });
      List<QueenPosition> queens = [];
      for (var i = 0; i < result.length; i++) {
        for (var j = 0; j < result[i].length; j++) {
          if (result[i][j].hasQueen) {
            queens.add(QueenPosition(x: i, y: j));
          }
        }
      }
      queens.shuffle(_random);
      widget.onQueenSelected(queens);
    });
  }
}