import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';
import 'package:projem/screens/yorum_add.dart';

import '../models/product.dart';

import '../models/yorum.dart';


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


class _ProductDetailState extends State {

  late List<Yorum> yorums;
  late int yorumCount;

  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtResim = TextEditingController();


  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtResim.text = product.resim;

    super.initState();
    getYorums(product.name);
  }

  Product product;


  _ProductDetailState(this.product);

//burada bir buton olacak ve ürün ekleme gibi yorum ekle olacak
  @override
  Widget build(BuildContext context) {
    IconButton commentbutton = IconButton(

      iconSize: 35.0,
      icon: Icon(Icons.chat_bubble_outline,
          color: Colors.green),
      onPressed: () => _comment(),
    );


    return Scaffold(
        resizeToAvoidBottomInset: false, // set it to false

        appBar: AppBar(
          title: Text("Ürün Adı: ${product.name}"),


        ),
        body: SingleChildScrollView(child: buildProductDetail(),),

        floatingActionButton: commentbutton
    );
  }

  buildProductDetail() {
    return Padding(
      //kendi içindeki uzaklık
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildField(),buildYorumList()
          ],
        )
    );
  }

  buildField() {
    var card = new Card(
      child: new Column(
        children: [
          new ListTile(

            title: CircleAvatar(backgroundColor: Colors.black12,child: Image.network(product.resim),),
          ),
          new Divider(color: Colors.blue, indent: 16.0,),
          new ListTile(

            title: new Text("${product.description} "
              , style: new TextStyle(fontWeight: FontWeight.w400),),
          )
        ],
      ),
    );
    return card;
  }

  ListView buildYorumList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: yorumCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(

            elevation: 1.0,
            margin: EdgeInsets.all(10),
            color: Colors.cyan,

            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.black12,child: Image.network("https://raw.githubusercontent.com/sinemsahn/flutterresimler/main/istockphoto-1300845620-612x612.jpg"),),
              //burays o resmi eklemeli
              title: Text(this.yorums[position].name),
              subtitle: Text(this.yorums[position].yorum),
              onTap: () {
                //goToDetail(this.yorums[position]);silsin
              }, //tıklanınca onun detayınına gidecek
            ),
          );
        });
  }

  void getYorums(String adi) async {
    var productsFuture = dbHelper.getYorums(adi);
    productsFuture.then((data) {
      setState(() {
        this.yorums = data;
        yorumCount = data.length;
        print(this.yorums);
        print(yorumCount);
      });
    });
  }

  _comment() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => YorumAdd(product.name)));
    });
  }


}

