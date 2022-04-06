import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),

    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  Widget calcbutton(String buttonText, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(buttonText);
        },
        child: Text(buttonText,
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: Border(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Калькулятор'), backgroundColor: Colors.black,),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Calculator display
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                    child: Text(equation,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 50
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                    child: Text(result,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 50
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here buttons functions
                  calcbutton('AC', Colors.grey, Colors.black),
                  calcbutton('C', Colors.grey, Colors.black),
                  calcbutton('^', Colors.grey, Colors.black),
                  calcbutton('/', Colors.purpleAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here buttons functions
                  calcbutton('7', Colors.grey.shade800, Colors.white),
                  calcbutton('8', Colors.grey.shade800, Colors.white),
                  calcbutton('9', Colors.grey.shade800, Colors.white),
                  calcbutton('x', Colors.purpleAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here buttons functions
                  calcbutton('4', Colors.grey.shade800, Colors.white),
                  calcbutton('5', Colors.grey.shade800, Colors.white),
                  calcbutton('6', Colors.grey.shade800, Colors.white),
                  calcbutton('-', Colors.purpleAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here buttons functions
                  calcbutton('1', Colors.grey.shade800, Colors.white),
                  calcbutton('2', Colors.grey.shade800, Colors.white),
                  calcbutton('3', Colors.grey.shade800, Colors.white),
                  calcbutton('+', Colors.purpleAccent, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    onPressed: () {
                      calculation("0");
                    },
                    shape: Border(),
                    child: Text("0",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white
                      ),
                    ),
                    color: Colors.grey.shade800,
                  ),
                  calcbutton('.', Colors.grey.shade800, Colors.white),
                  calcbutton('=', Colors.purpleAccent, Colors.white),
                ],
              )
            ],
          ),
        )
    );
  }

  String equation = "0";
  String result = "0";
  String expression = "";

  calculation(String buttonText){
    setState(() {
      if(buttonText == "AC"){
        equation = "0";
        result = "0";
      }

      else if(buttonText == "C"){
        equation = equation.substring(0, equation.length - 1);
        print(16);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('x^2', '^');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if(result!='Infinity'){
            print(result);
          }else {
            result= "Деление на 0!";
          }
        } catch (e) {
          result = "Ошибка";
        }
      }

      else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}
