import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String _info = "Informe os seus dados!";

  void _resetarCampos() {
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _info = "Informe os seus dados!";
    });
  }

  void _calculaIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _info = "Abaixo do Peso: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso Ideal: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente acima do Peso: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Obesidade Grau I: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade Grau II: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40.0) {
        _info = "Obesidade Grau III: ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetarCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.face,
                    color: Colors.green,
                    size: 110.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso(Kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                    controller: pesoController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura(cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                    controller: alturaController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 20.0, right: 50.0, left: 50.0),
                    child: Container(
                      height: 55.0,
                      child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            _calculaIMC();
                          }
                        },
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    "$_info",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                  ),
                ],
              ),
            )));
  }
}
