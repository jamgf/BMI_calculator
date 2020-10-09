import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: IMCCalculator(),
  ));
}

class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  String infoText = "Informe seus dados";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        infoText =
            "Seu IMC é ${imc.toStringAsPrecision(2)}, você está abaixo do peso";
      } else if (imc < 25) {
        infoText =
            "Seu IMC é ${imc.toStringAsPrecision(2)}, você está dentro do peso";
      } else if (imc < 30) {
        infoText =
            "Seu IMC é ${imc.toStringAsPrecision(2)}, você está acima do peso";
      } else if (imc < 35) {
        infoText =
            "Seu IMC é ${imc.toStringAsPrecision(2)}, você está com Obesidade I";
      } else {
        infoText =
            "Seu IMC é ${imc.toStringAsPrecision(2)}, você está com Obesidade II";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Peso em kilograma",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                controller: weightController,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura em centímetros",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                controller: heightController,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
