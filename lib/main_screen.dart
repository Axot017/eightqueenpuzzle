import 'package:eightqueenspuzzle/board_widget.dart';
import 'package:eightqueenspuzzle/queen_position.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static const List<int> supportedSizes = [1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  int selectedSize = 8;
  int keyValue = 0;
  List<QueenPosition> _queensPositions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Problem ośmiu hetmanów'),),
      body: Column(
        children: <Widget>[
          SizedBox(height: 16,),
          Text('Select board size'),
          SizedBox(height: 16,),
          dropdown,
          SizedBox(height: 16,),
          Stack(
            children: <Widget>[
              Board(selectedSize, setQueens, key: ValueKey(keyValue),),
              ..._getQueens()
            ],
          ),
          SizedBox(height: 16,),
          RaisedButton(
            child: Text('Refresh'),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              keyValue++;
              setState(() {
                selectedSize = selectedSize;
              });
            },
          )
        ],
      ),
    );
  }

  Iterable<Widget> _getQueens() sync* {
    double fieldSize = MediaQuery.of(context).size.width / selectedSize;
    double padding = fieldSize * 0.15;
    double queenSize = fieldSize * 0.7;
    for (var i in _queensPositions) {
      yield AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        top: (i.x * fieldSize) + padding,
        left: (i.y * fieldSize) + padding,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          height: queenSize,
          width: queenSize,
          child: Image.asset('assets/images/queen.png',
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  void setQueens(List<QueenPosition> queens) {
    setState(() {
      _queensPositions = queens;
    });
  }


  Widget get dropdown => DropdownButton<int>(
    value: selectedSize,
    onChanged: (newValue) {
      setState(() {
        selectedSize = newValue;
      });
    },
    items: supportedSizes.map((value) => DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString())
    )).toList(),
  );
}