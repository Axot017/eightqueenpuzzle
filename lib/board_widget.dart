import 'package:eightqueenspuzzle/calculate_queens_position.dart';
import 'package:eightqueenspuzzle/field_state.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final int size;

  Board(this.size, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => BoardState();
}

class BoardState extends State<Board> {
  List<List<FieldState>> fields = [];

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
            return getField(fields[rowIndex][index], isWhite ? Colors.orangeAccent.withOpacity(0.5) : Colors.brown);
          }),
        );
      }),
    );
  }

  Widget getField(FieldState state, Color color) => Container(
    height: itemSize,
    width: itemSize,
    alignment: Alignment.center,
    color: color,
    child: state.hasQueen ? Image.asset('assets/images/queen.png',
      width: itemSize * 0.7,
      height: itemSize * 0.7,
    ) : Container(),
  );

  initBoard() {
    fields = List<List<FieldState>>.generate(widget.size, (_) => List<FieldState>.generate(widget.size, (_) => FieldState()));
    calculateQueensPositions(widget.size).then((result) {
      setState(() {
        fields = result;
      });
    });
  }
}