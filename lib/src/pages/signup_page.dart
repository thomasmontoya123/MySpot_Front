import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name = '';
  String _userName = '';
  String _lastName = '';
  String _mail = '';
  String _password = '';
  String _userPhone = '';



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crear cuenta'),
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
                    _nameInput(),
                    Divider(),
                    _emailInput(),
                    Divider(),
                    _passwordInput(),
                    Divider(),
                    _phoneInput(),
                    SizedBox(height: 30.0),
                    _submitButton(context)
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
          _userName = value;
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
        helperText: 'Minimo 6 caracteres',
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
            // Validate returns true if the form is valid, otherwise false.
            if (_formKey.currentState.validate()){
              String url = 'http://18.233.97.235:3000/api/v1/user-signup/';
              Map<String, String> headers = {"Content-type": "application/json"};
              String json = jsonEncode({"name": _name, "lastName": _lastName, "userName": _userName, "phone": _userPhone, "email": _mail, "password": _password});
              
              Response response = await post(url, headers: headers, body: json);

              int statusCode = response.statusCode;

              if (statusCode == 201){
                _showAlert(context);
              }
            }
          },
          child: Text(
            'Crear usuario',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }

  _phoneInput() {
  return TextFormField( 
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingres su telefon';
        }
        _validNumberChecker(value);
        return null;
      },

      keyboardType: TextInputType.number,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

        hintText: 'Telefono',
        labelText: 'Telefono',
        suffixIcon: Icon(Icons.phone),
        icon: Icon(Icons.phone_iphone),
      ),

      onChanged: (value){
        setState(() {
          _userPhone = value;
          }
        );
      },
    );
  }

  _nameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese su nombre y apellido';
        }
        return null;
      },

      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

        hintText: 'Nombre',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle),
      ),

      onChanged: (value){
        setState(() {
          _name = value.split(" ")[0];
          _lastName = value.split(" ")[1];


          }
        );
      },
    );
  }

  String _validNumberChecker(String value){

    if (value[0] != '3'){
      return 'Ingrese un telefono valido';
    }
    return null;

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

}