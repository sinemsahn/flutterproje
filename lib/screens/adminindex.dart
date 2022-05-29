// main.dart



import 'package:flutter/material.dart';
import 'package:projem/data/dbHelper.dart';
import 'package:projem/screens/product_add.dart';
import 'package:projem/screens/product_delete.dart';

import '../models/product.dart';

void main() {
  runApp(const MySecondPage());
}

class MySecondPage extends StatelessWidget {
  const MySecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Admin Sayfası',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.blue)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dbHelper = new DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Sayfası'),
      ),
      body: const Center(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'Ürün Sil',
              onPressed: () {
                goTooDeletePage();
              },
              child: const Icon(
                Icons.delete,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: 'Ürün Ekle',
              onPressed: () {
                goToProductAdd();
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Productadd()));
    if (result != null) {
      //kullanıcı geriye dönmediyse
      if (result) {
        //ürünleri yeniden listelemesi lazım
        //init state içi çalışır veya
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    }); //bir sonuc gelecek
    // bu sayfadaki statei başlat demek oluyor o sayfa açıldığında çalışan bloğu olarak düşünülebilir

  }

  void goTooDeletePage() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductDelete()));
    if (result != null) {
      //kullanıcı geriye dönmediyse
      if (result) {
        //ürünleri yeniden listelemesi lazım
        //init state içi çalışır veya
        getProducts();
      }
    }
  }


}
