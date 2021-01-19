import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:smartpluspharma/views/verifyCode.dart';
import 'package:string_validator/string_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  String telephone = '';
  String codePharma = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white60);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
                  child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 SizedBox(
                  height: 80.0,
                ),
                companyName(),
                SizedBox(
                  height: 20.0,
                ),
                codePharmadCard(),
                telephoneCard(),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  * Custom fonction witch return a flutter company name 
  **/
  Widget companyName() {
    return Image(
      width: 100,
      height: 100,
      image: AssetImage('images/logo.png'),
    );
  }

  /*
  * Custom fonction witch return a flutter email card widget
  **/
  Widget telephoneCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 25.0),
      child: ListTile(
        leading: Icon(
          Icons.phone,
          color: Color.fromRGBO(33, 37, 41, 1),
        ),
        title: TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Téléphone',
            border: InputBorder.none,
          ),
          // validator: (String value) {
          //   if (!isBase64(value)) {
          //     return 'Numéro incorrecte';
          //   }
          //   return null;
          // },
          onSaved: (String value) {
            telephone = value;
          },
        ),
      ),
    );
  }

  /*
  * Custom fonction witch return a flutter password card widget
  **/
  Widget codePharmadCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          Icons.lock,
          color: Color.fromRGBO(33, 37, 41, 1),
        ),
        title: TextFormField(
          //obscureText: true,
          decoration: InputDecoration(
            hintText: 'Entrez code pharmacie',
            border: InputBorder.none,
          ),
          validator: (String value) {
            if (!isLength(value, 6)) {
              return 'caractère saisi insuffisant';
            }
            return null;
          },
          onSaved: (String value) {
            codePharma = value;
          },
        ),
      ),
    );
  }

  /*
  * Custom fonction witch return a flutter button widget
  **/
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
              'Se connecter',
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
          print(
              'Telephone $telephone and code pharmacie $codePharma is ready to send to API');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyCode()),
          );
        }
      },
    );
  }
}
