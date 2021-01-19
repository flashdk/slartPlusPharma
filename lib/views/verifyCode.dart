import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:smartpluspharma/views/accueil.dart';

class VerifyCode extends StatefulWidget {
  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final formkey = GlobalKey<FormState>();
  String code = '';

  Widget confirmeCode() {
    return Card(
      margin: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 25.0),
      child: ListTile(
        leading: Icon(
          Icons.code,
          color: Color.fromRGBO(33, 37, 41, 1),
        ),
        title: TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Entrez le code',
            border: InputBorder.none,
          ),
          // validator: (String value) {
          //   if (!isBase64(value)) {
          //     return 'Numéro incorrecte';
          //   }
          //   return null;
          // },
          onSaved: (String value) {
            code = value;
          },
        ),
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Color.fromRGBO(0, 89, 178, 1),
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Container(
        width: 150.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Confirmer',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        if (formkey.currentState.validate()) {
          formkey.currentState.save();
          print('Code $code is ready to send to API');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Accueil()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white60);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              confirmeCode(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
