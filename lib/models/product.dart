class Product{
  int _id=0;
  String _name="";
  String _description="";
  String _resim="";
  String _kategori="";

  int get id=> _id;
  String get name=> _name;
  String get description => _description;
  String get resim=> _resim;
  String get kategori => _kategori;

  set name(String newname){
    _name = newname;
  }
  set description(String newdescription){
    _description = newdescription;
  }
  set resim(String newresim){
    _resim = newresim;
  }
  set kategori(String newkategori){
    _kategori=newkategori;
  }
  Product(this._name, this._description, this._resim,this._kategori);
  Product.withId(this._id,this._name,this._description,this._resim,this._kategori);


Map<String, dynamic> toMap(){
  var map= Map<String,dynamic>();
  map["name"]=_name;
  map["description"]=_description;
  map["resim"]=_resim;
  map["kategori"]=_kategori;
  if(_id != null){
    map["id"]=_id;
  }
  return map;
}

//to object yazacağız aşağıda
  Product.fromObject(dynamic o){
    this._id= int.tryParse(o["id"].toString())!;
    this._name=o["name"];
    this._description=o["description"];
    this._resim=o["resim"];
    this._kategori=o["kategori"];
  }








}