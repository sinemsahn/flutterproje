
import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';

import '../models/yorum.dart';
import '../models/product.dart';

class YorumAdd extends StatefulWidget{

  String product_adi;
  YorumAdd(this.product_adi);
  @override
  State<StatefulWidget> createState() {
    return YorumAddState(product_adi);
  }

}

class YorumAddState  extends State{
  String product_adi;
  YorumAddState(this.product_adi);

  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtYorum = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Yorum"),
      ),
      body: Padding(
        //kendi içindeki uzaklık
          padding: EdgeInsets.all(30.0),
          child:Column(
            children: <Widget>[
              buildNameField(), buildYorumField(),  buildSaveButton()
            ],
          )
      ),
    );
  }


  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ad: "),
      controller: txtName, //oraya otomatik ekler

    );
  }
  buildYorumField() {
    return TextField(
      decoration: InputDecoration(labelText: "Yorum: "),
      controller: txtYorum, //oraya otomatik ekler

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
    var result = await dbHelper.insertYorum(new Yorum(txtName.text, txtYorum.text),this.product_adi);
    //print("Tamam");
    //print(result.toString());
    AlertDialog(
      title: new Text(txtName.text),

    );
   Navigator.pop(context,true);

  }
}