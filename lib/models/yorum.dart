class Yorum{
  int _id=0;
  String _name="";
  String _yorum="";

  int get id=> _id;
  String get name=> _name;
  String get yorum => _yorum;



  set name(String newname){
    _name = newname;
  }
  set yorum(String newyorum){
    _yorum = newyorum;
  }


  Yorum(this._name, this._yorum);
  Yorum.withId(this._id,this._name,this._yorum);


  Map<String, dynamic> toMap(){
    var map= Map<String,dynamic>();
    map["name"]=_name;
    map["yorum"]=_yorum;


    if(_id != null){
      map["id"]=_id;
    }
    return map;
  }

//to object yazacağız aşağıda
  Yorum.fromObject(dynamic o){
    this._id= int.tryParse(o["id"].toString())!;
    this._name=o["name"];
    this._yorum=o["yorum"];


  }

//urun tablosu kullanıcı ve resim






}