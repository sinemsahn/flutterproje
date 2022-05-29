import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';

import '../main.dart';
import '../models/product.dart';

class ProductDelete extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductDeleteState();
  }

}

class ProductDeleteState  extends State{
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;
  @override
  void initState() {

    getProducts();

  }

  //ürünler listeleme işlemi olur açılınca

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title:  Text("Ürün listesi"),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10.0),
              child: new IconButton(
                icon: new Icon(Icons.login, size: 30.0,color: Colors.white),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));

                },

              ),


            )
          ],
        ),
        body: buildProductList()
    );
  }

  ListView buildProductList() {

    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.black12,child: Image.network(this.products[position].resim),),//burays o resmi eklemeli
              title: Text(this.products[position].name),
              subtitle: Text("Ürün kategorisi"),
              onTap: (){
                String adi = this.products[position].name;
                goToDelete(adi);
              }, //tıklanınca onun detayınına gidecek
            ),
          );
        });

  }

  void getProducts() async{
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data){
      setState(() {
        this.products = data;
        productCount= data.length;
      });

    }); //bir sonuc gelecek
    // bu sayfadaki statei başlat demek oluyor o sayfa açıldığında çalışan bloğu olarak düşünülebilir

  }
  void goToDelete(String adi) async{
    //silip tekrar bu sayfaya dönsün

    int result = await dbHelper.deleteProduct(adi);
    print(result);

  }



  //önce tüm ürünler listelenmeli sonra sil butonu ile silinmeli

}