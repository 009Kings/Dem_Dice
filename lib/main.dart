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

  void _incrementCounter(int max) {
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset("assets/d$dX.png", scale: 2.0, width: 64.0, height: 64.0),
                Text("$dX-sided die")
              ],
            ),
            RaisedButton(
              onPressed: () => _incrementCounter(dX),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Colors.teal, Colors.blue],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text('Roll the Dice'),
              ),
            ),
            Text(
                "${_result['d${dX}']}",
                style: Theme.of(context).textTheme.display1,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildDiceRow(4),
            _buildDiceRow(6),
            _buildDiceRow(8),
            _buildDiceRow(10),
            _buildDiceRow(12),
            _buildDiceRow(20),
            RaisedButton(
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
          ],
        ),
      ),
    );
  }
}
