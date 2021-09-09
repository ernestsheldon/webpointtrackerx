import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class SpringsCalculator extends StatefulWidget {
  SpringsCalculator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SpringsCalculatorState createState() => _SpringsCalculatorState();
}

class _SpringsCalculatorState extends State<SpringsCalculator> {
  late double springId;
  late double wireId;
  late double springLength;

  late double springInches;
  late String springInchesText;

  TextEditingController _springId = TextEditingController();
  TextEditingController _wireId = TextEditingController();
  TextEditingController _springLength = TextEditingController();

  @override
  void initState() {
    springId = 0.650;
    wireId = .146;
    springLength = 47.38;

    _springId.text = springId.toString();
    _wireId.text = wireId.toString();
    _springLength.text = springLength.toString();
    _springLength.text = "47.38";

    springInches = ((springId + wireId) * 3.14) * (springLength / wireId) - 2;
    springInchesText = formatNumber(springInches);

    super.initState();
  }

  calculate(BuildContext context) {
    if (_springId.text.isNotEmpty &
        _wireId.text.isNotEmpty &
        _springLength.text.isNotEmpty) {
      final double curSpringId = double.parse(_springId.text);
      final double curWireId = double.parse(_wireId.text);
      final double curSpringLength = double.parse(_springLength.text);

      setState(() {
        springId = double.parse(_springId.text);
        wireId = double.parse(_wireId.text);
        springLength = double.parse(_springLength.text);

        springInches =
            ((curSpringId + curWireId) * 3.14) * (curSpringLength / curWireId) -
                2;
      });
      springInchesText = formatNumber(springInches);
    }
  }

//force only two digits past decimal to show
  String formatNumber(double n) {
    return n
        .toStringAsFixed(2); //removes all trailing numbers after the decimal.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 250,
                    height: 150,
                    child: Image.asset(
                        "spring.jpg",scale: 1.0,)),
                Text(
                  'Spring Calculator',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Wire size: $wireId + Spring Length $springLength + Spring Id $springId  ",
                  style: TextStyle(
                      backgroundColor: Colors.blueAccent.withAlpha(55),

                      fontSize: 12.0,
                      fontWeight: FontWeight.w900),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]+' r'\.?'))
                    //\d+\.\d
                    //RegExp('([0-9]+(\.[0-9]+)?)')
                  ],
                  controller: _springId,
                  decoration: InputDecoration(
                    labelText: "Enter Spring ID",
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 .? 0-9{2}]'))
                  ],
                  controller: _springLength,
                  decoration: InputDecoration(
                    labelText: "Enter  Spring Length",
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]'))
                  ],
                  controller: _wireId,
                  decoration: InputDecoration(
                    labelText: "Enter Wire Size ",

                  ),
                ),
                Text(

                  'Spring Inches:  $springInchesText  ',
                  style: TextStyle(

                    backgroundColor: Colors.blueAccent,
                    fontSize: 24.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 30),

                ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/");
                    }, child: Icon(Icons.arrow_back)),
                SizedBox(height: 20),
              ],
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          calculate(context);
        },
        tooltip: 'Calculate',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
