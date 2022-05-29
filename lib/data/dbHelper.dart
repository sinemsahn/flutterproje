import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';
import '../models/yorum.dart';


class DbHelper{
  static Database? _db;
  Future<Database?> get db async{
    if(_db==null){
      _db= await initializeDb();
    }
    return _db;
  }
  Future<Database> initializeDb() async{
    String dbPath = join(await getDatabasesPath(),"taat.db");
    //db oluşur
    var ttdb = await openDatabase(dbPath,version: 1,onCreate: createDb);
    return ttdb;
  }

  Future<void> createDb(Database db, int version) async {
    await  db.execute("create table products(id integer , name text, description text,  resim text)");

  }



//dbdeki tüm ürünleri listelemek için kod yazalım. liste formatında gelmelidir.
  Future<List<Product>> getProducts()async{
    Database? db = await this.db;
    var result = await db?.query("products");
    return List.generate(result!.length, (i){
      return Product.fromObject(result[i]); //verileni alıp her bir map ile oluşturulup döner
    });
    //tüm db tabloasunu döner
  }

  Future<List<Yorum>> getYorums(String adi)async{
    Database? db = await this.db;
    String sql = "'${adi}'";
    var result = await db?.query(sql);
    return List.generate(result!.length, (i){
      return Yorum.fromObject(result[i]); //verileni alıp her bir map ile oluşturulup döner
    });
    //tüm db tabloasunu döner
  }
  //adi verilen




  Future<int> insert(Product product ) async{
    //kayıda bir şey eklenip eklenmediğinin sonucu için 0-1 dönecek
    Database? db = await this.db;

    var result = await db!.insert("products",product.toMap());
    String sql= "create table  '${product.name}' (id integer , name text,   yorum text)";
    await db.execute(sql);
    return result;
  }

//ürün eklendiğinde aynı zamanda onun adında bir tabblosu olacak
  //o tabloya insert etsin yorum
  Future<int> insertYorum(Yorum yorumm,String tablo ) async{
    //kayıda bir şey eklenip eklenmediğinin sonucu için 0-1 dönecek
    Database? db = await this.db;

    var result = await db!.insert(tablo,yorumm.toMap());
    return result;
  }



  Future<int> deleteProduct(String name) async{
    //kayıda bir şey eklenip eklenmediğinin sonucu için 0-1 dönecek
    Database? db = await this.db;

    var result = await db!.rawDelete("delete from products where name='$name'"); //bu sql açığı olur
    return result;
  }



  Future<int> update(Product product ) async{ //daha güvenli olanı
    //kayıda bir şey eklenip eklenmediğinin sonucu için 0-1 dönecek
    Database? db = await this.db;

    var result = await db!.update("products", product.toMap(),where: "id=?",whereArgs: [product.id]); //bu sql açığı olur

    return result;
  }


}