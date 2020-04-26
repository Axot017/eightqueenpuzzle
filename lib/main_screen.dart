import 'package:eightqueenspuzzle/board_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static const List<int> supportedSizes = [1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  int selectedSize = 8;

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
          Board(selectedSize, key: UniqueKey(),),
          SizedBox(height: 16,),
          RaisedButton(
            child: Text('Refresh'),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                selectedSize = selectedSize;
              });
            },
          )
        ],
      ),
    );
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