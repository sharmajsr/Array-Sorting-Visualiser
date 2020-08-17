import 'package:flutter/material.dart';
import 'dart:math';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<int> _numbers = [];

  int _sampleSize = 500;

  _randomize() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; i++) {
      _numbers.add(Random().nextInt(_sampleSize));
    }
    // _sort();
    setState(() {});
  }

  _sort() async {
    for (int i = 0; i < _numbers.length - 1; i++) {
      for (int j = 0; j < _numbers.length - i - 1; j++) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 50));
        setState(() {});
      }
    }
  }

  _insertionSort() async {
    for (int i = 0; i < _numbers.length; i++) {
      int j = i - 1;
      int val = _numbers[i];
      while (j >= 0 && _numbers[j] > val) {
        _numbers[j + 1] = _numbers[j];
        j = j - 1;
        await Future.delayed(Duration(microseconds: 50));
        setState(() {});
      }
      _numbers[j + 1] = val;
    }
  }

  _selectionSort()async
  {
    for(int i=0;i<_numbers.length-1;i++)
    {
      int min = i;
        for(int j=i+1;j<_numbers.length;j++)
        {
          if(_numbers[j]<_numbers[min])
            {
              min=j;
            }
          await Future.delayed(Duration(microseconds: 50));
          setState(() {});

        }
        int temp= _numbers[i];
        _numbers[i]=_numbers[min];
        _numbers[min]=temp;

    }
  }

  @override
  void initState() {
    super.initState();
    _randomize();
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting Visualizer'),
      ),
      body: Container(
        child: Row(
          children: _numbers.map((int number) {
            counter++;
            return CustomPaint(
              painter: BarPainter(
                width: MediaQuery.of(context).size.width / _sampleSize,
                value: number,
                index: counter,
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(child: Text('Randomize'), onPressed: _randomize),
          FlatButton(child: Text('Sort'), onPressed: _selectionSort),
        ],
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();

    paint.color = Colors.red;
    paint.strokeWidth = 5.0;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(index * width, 0),
        Offset(index * width, value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
