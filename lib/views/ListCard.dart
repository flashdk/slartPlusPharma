import 'package:flutter/material.dart';
import 'package:smartpluspharma/models/commandeModel.dart';

class ListCard extends StatefulWidget {
  final CommandeModel commande;
  final Map env;

  ListCard(this.commande, this.env);

  _ListCard createState() => new _ListCard();
}

class _ListCard extends State<ListCard> {
  CommandeModel commande;
  String name, email, price = "Price";

  Widget build(BuildContext context) {
    commande = widget.commande;
    if(!widget.env['prices'].isEmpty) {
      for(int i=0; i < widget.env['prices'][1].length; i++) {
        if(widget.env['prices'][1][i]['id'] == commande.id) {
          this.price = widget.env['prices'][1][i]['price'];
        }
      }
    }

    //get an extra from name an email text comming from api
    (commande.name.length > 16)
        ? name = commande.name.substring(0, 16) + '...'
        : name = commande.name;
    (commande.email.length > 20)
        ? email = commande.email.substring(0, 20) + '...'
        : email = commande.email;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(commande.name.substring(0, 1).toUpperCase()),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: Row(
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Definir le prix'),
                            content: TextField(
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              controller: widget.env['customControler'],
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                elevation: 5.0,
                                child: Text('Ok'),
                                onPressed: () {
                                  String priceTape = widget
                                      .env['customControler'].text
                                      .toString();
                                  widget.env['addProductPrice'](
                                      {"price": priceTape, "id": commande.id});
                                  Navigator.of(context).pop(widget
                                      .env['customControler'].text
                                      .toString());
                                  setState(() {
                                    print("price is " + priceTape);
                                    price = priceTape;
                                  });
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: new Container(
                      margin: const EdgeInsets.all(0.0),
                      child: new Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        price = "0";
                      });
                    },
                    child: new Container(
                      margin: const EdgeInsets.all(0.0),
                      child: new Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(email),
              price == "0" ? Text("Epuisé") : Text(price),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
