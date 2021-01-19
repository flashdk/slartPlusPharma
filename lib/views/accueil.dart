import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:smartpluspharma/models/commandeModel.dart';
import 'package:smartpluspharma/models/defineProductPriceModel.dart';
import 'package:smartpluspharma/views/ListCard.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int numOrdonance = 10234;
  int selectedProduct;

  String priceTape = "";
  CommandeModel listIndex;

  var productPrice = [];
  DefineProductPriceModel defineOnePrice;
  TextEditingController customController = TextEditingController();

  Future<List<CommandeModel>> _getCommande() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/comments');
    var jsonData = json.decode(data.body);

    List<CommandeModel> commandes = [];

    for (var t in jsonData) {
      CommandeModel commande =
          CommandeModel(t["id"], t["name"], t["email"], t["body"]);
      commandes.add(commande);
    }
    return commandes;
  }

  Widget pageHeader() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white30,
              radius: 45,
              backgroundImage: AssetImage("images/logo.png"),
            ),
            SizedBox(width: 40.0),
            Text('Pharmacie name'),
          ],
        ),
      ),
    );
  }

  Widget showCommandeheader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Ordonnance N°: $numOrdonance",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            textColor: Color.fromRGBO(0, 89, 178, .7),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Envoyer',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.send),
                ],
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void addProductPrice(Map _map) {
    if (productPrice.isEmpty) {
      productPrice.add(numOrdonance);
      productPrice.add([_map]);
    } else {
      this.productPrice[1].add(_map);
    }

    customController.text = "";
    print(productPrice);
  }

  Widget pageContent() {
    return Expanded(
      flex: 4,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: FutureBuilder(
          future: _getCommande(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Image.asset(
                    'images/loader.gif',
                    fit: BoxFit.fill,
                    height: 180,
                  ),
                ),
              );
            } else {
              Orientation orientation = MediaQuery.of(context).orientation;

              if (orientation == Orientation.portrait) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ListCard(snapshot.data[index], {
                      'prices': productPrice,
                      'customControler': customController,
                      'addProductPrice': this.addProductPrice
                    });
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget pageFooter() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 20.0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: RaisedButton(
          color: Color.fromRGBO(0, 89, 178, 1),
          onPressed: () {
            print('affiche le diaolog');
            //createAlertDialog(context);
          },
          child: Text(
            'Se deconnecter',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Widget showPrice(List productPrice, int id) {
  //   if (productPrice.isEmpty) {
  //     return Text(
  //       "Price",
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     );
  //   } else {
  //     for (int i = 0; i < productPrice[1].length; i++) {
  //         int current = productPrice[1][i]["id"];
  //         if (current == id) {
  //           return Text(productPrice[1][i]["price"].toString());
  //         }
  //       }

  // productPrice[1].forEach((item) {
  //   if (item.id == selectedProduct) {

  //   }
  // });
  // productPrice[1].asMap().map(
  //       (items) => {},
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(0, 89, 178, .7));
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 89, 178, 1),
          leading: Container(
            color: Colors.white,
            padding: EdgeInsets.all(7),
            child: Image(
              image: AssetImage('images/logo.png'),
            ),
          ),
          title: const Text('Emaüs'),
        ),
        body: Builder(
          builder: (_) {
            return Column(
              children: <Widget>[
                //pageHeader(),
                showCommandeheader(),
                SizedBox(
                  child: Container(
                    height: 5.0,
                  ),
                ),
                pageContent(),
                pageFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
