import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  String _mail = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inicio de sesion'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Add TextFormFields and RaisedButton here.
                    _emailInput(),
                    Divider(),
                    _passwordInput(),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _submitButton(context),
                        SizedBox(width: 10.0),
                        _navigateToSignup(),
                      ]
                    )
                  ]
                )
            )
          ],
        ),
      )
    );
  }

  Widget _emailInput(){
    return TextFormField( 
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese su correo';
        }
        return null;
      },

      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

        hintText: 'Correo',
        labelText: 'Correo',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
      ),

      onChanged: (value){
        setState(() {
          _mail = value;
          }
        );
      },
    );
  }

  _passwordInput() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese su contraseña';
        }
        return null;
      },

      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        suffixIcon: Icon(Icons.lock),
        icon: Icon(Icons.lock),
      ),
      onChanged: (value){
        setState(() {
          _password = value;
        });
      },
    );
  }


  Widget _submitButton(BuildContext context){
    return ButtonTheme(
        minWidth: 90.0,
        height: 40.0,
        child: RaisedButton(
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () async{

            if (_formKey.currentState.validate()){
              String url = 'http://18.233.97.235:3000/api/v1/user-login/';
              Map<String, String> headers = {"Content-type": "application/json"};
              String json = jsonEncode({"userName": _mail, "password": _password});
              
              Response response = await post(url, headers: headers, body: json);

              int statusCode = response.statusCode;

              print(response.body);

              if (statusCode == 200){
                _showAlert(context);
              }

              if (statusCode == 404){
                _showAlertNoUserFound(context);
              }

              if (statusCode == 401){
                _showAlertIncorrectdata(context);
              }
            }

          },
          child: Text(
            'Iniciar sesion',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }

  _navigateToSignup(){
    return ButtonTheme(
        minWidth: 90.0,
        height: 40.0,
        child: RaisedButton(
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: Text(
            'Crear cuenta',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }


  void _showAlert(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Bienvenido'),
          content: Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            FlutterLogo(size: 100)
          ], 
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pushNamed(context, '/loged'), 
              )
          ],
        );

      }
    );
  }

  void _showAlertNoUserFound(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Usuario no existe, cree una cuenta'),
          content: Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            FlutterLogo(size: 100)
          ], 
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pushNamed(context, '/signup'), 
              )
          ],
        );

      }
    );
  }

  void _showAlertIncorrectdata(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Datos incorrectos'),
          content: Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            FlutterLogo(size: 100)
          ], 
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pushNamed(context, '/login'), 
              )
          ],
        );

      }
    );
  }

}
