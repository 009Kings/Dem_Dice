import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DemDice());

class DemDice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dem Dice',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AllDemDice(title: 'Roll the Dice'),
    );
  }
}

class AllDemDice extends StatefulWidget {
  AllDemDice({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AllDemDiceState createState() => _AllDemDiceState();
}

class _AllDemDiceState extends State<AllDemDice> {
  Map<String, int> _result = {
    'd4': 0,
    'd6': 0,
    'd8': 0,
    'd10': 0,
    'd12': 0,
    'd20': 0,
  };

  void _rollDie(int max) {
    setState(() {
      _result['d${max}'] = Random().nextInt(max) + 1;
    });
  }

  void _clearCounters() {
    setState(() {
      _result.forEach((key, value)=> _result[key] = 0);
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget _buildDiceRow(int dX) {
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  ConstrainedBox( 
                    constraints: BoxConstraints(maxHeight: 64, maxWidth: 64), 
                    child: Ink.image( image: AssetImage("assets/d$dX.png"), 
                    fit: BoxFit.fitHeight, 
                    child: InkWell( 
                      onTap: () => _rollDie(dX), 
                      ), 
                    ), 
                  ),
                  Text(
                    'Click to Roll',
                    style: Theme.of(context).textTheme.caption,
                    )  
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child:  Text(
                  "${_result['d${dX}']}",
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
          ],
        )
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            _buildDiceRow(4),
            _buildDiceRow(6),
            _buildDiceRow(8),
            _buildDiceRow(10),
            _buildDiceRow(12),
            _buildDiceRow(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: RaisedButton(
                onPressed: () => _clearCounters(),
                textColor: Colors.black,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Colors.red, Colors.orange],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Clear all Rolls'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
