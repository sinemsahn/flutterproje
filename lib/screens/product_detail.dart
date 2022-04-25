import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';

import '../models/product.dart';
import 'package:projem/screens/yorum_add.dart';

class ProductDetail extends StatefulWidget{
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }

}
//BU SAYFA AÇILINCA YORUMLARI DA ALMALI DİREKT
enum Options{delete,update}


class _ProductDetailState extends State{
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtResim = TextEditingController();
  var txtKategori=TextEditingController();

  @override
  void initState(){
    txtName.text=product.name;
    txtDescription.text=product.description;
    txtResim.text=product.resim;
    txtKategori.text=product.kategori;
    super.initState();
  }

  Product product;
  _ProductDetailState(this.product);

//burada bir buton olacak ve ürün ekleme gibi yorum ekle olacak
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı: : ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context)=><PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value:Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value:Options.update,
                child: Text("Güncelle"),
              ),

            ],

          )
        ],

      ),
      body: buildProductDetail(),
      floatingActionButton:  FloatingActionButton(
        onPressed: (){
          //ürün açıklama sayfasına gitsin
          goToYorumAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yorum ekle",
      )

    );
  }

  buildProductDetail() {
    return Padding(
      //kendi içindeki uzaklık
        padding: EdgeInsets.all(30.0),
        child:Column(
          children: <Widget>[
            buildNameField(), buildDescriptionField(), buildResimField(), buildKategori()
          ],
        )
    );
  }
  buildResimField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Resmi"),
      controller: txtResim, //oraya otomatik ekler

    );
  }
  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: txtName, //oraya otomatik ekler

    );
  }
  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription, //oraya otomatik ekler

    );
  }
  buildKategori() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün kategorisi"),
      controller: txtKategori, //oraya otomatik ekler

    );
  }
  void selectProcess(Options options) async{
    switch(options){
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;

      case Options.update:
        await dbHelper.update(Product.withId(product.id, txtName.text, txtDescription.text, txtKategori.text,txtResim.text));
        Navigator.pop(context, true);
        break;
      default:

    }

  }

  void goToYorumAdd() async{
    print("tamam");




  }
}

