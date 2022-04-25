//ürünleri getirecek
import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';
import 'package:projem/screens/HomePage.dart';
import 'package:projem/screens/product_add.dart';
import 'package:projem/screens/product_detail.dart';

import '../models/product.dart';


class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State{
  var dbHelper = new DbHelper();
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
                Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));

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
              leading: CircleAvatar(backgroundColor: Colors.black12,child: Text("p"),),//burays o resmi eklemeli
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].kategori),
              onTap: (){
                goToDetail(this.products[position]);
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

  void goToDetail(Product product) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if (result != null){
      if(result){
        getProducts();
      }

    }
  }


}


