import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';

import '../models/product.dart';

class Productadd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }

}

class ProductAddState  extends State{
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtResim = TextEditingController();
  var txtDescription = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni ürün ekle"),
      ),
      body: Padding(
        //kendi içindeki uzaklık
          padding: EdgeInsets.all(30.0),
          child:Column(
            children: <Widget>[
              buildNameField(), buildDescriptionField(), buildUnitPriceField(), buildSaveButton()
            ],
          )
      ),
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtName, //oraya otomatik ekler

    );
  }
  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması"),
      controller: txtDescription, //oraya otomatik ekler

    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Resim"),
      controller: txtResim, //oraya otomatik ekler

    );
  }


  buildSaveButton() {
    return FlatButton(
      child: Text("Ekle"),
      onPressed: (){
        addProduct();
      },
    );
  }

  void addProduct() async{
    var result = await dbHelper.insert(new Product(txtName.text, txtDescription.text,txtResim.text));
    AlertDialog(
      title: new Text(result.toString()),
    );
    Navigator.pop(context,true);

  }
}