

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  late String username;
  late String password;
  final _formKey= GlobalKey<FormState>();

  get context => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Text('Admin Girişi'),
      ),
      body: Form(
        child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[

            TextFormField(

              decoration: InputDecoration (
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple
                  ),

                ),
                labelText: "Kullanıcı Adı",
                border: OutlineInputBorder()

              ),
              validator:(value) {
                if(value!.isEmpty){
                  return "Kullanıcı Adını Giriniz..";

                }
                else{
                  return null;
                }
              },
              onSaved: (value){
                username=value!;
              },
            ) ,SizedBox(height: 10.0),
            TextFormField(

              decoration: InputDecoration (
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.purple
                    ),

                  ),
                  labelText: "Parola",
                  border: OutlineInputBorder()

              ),
              validator:(value) {
                if(value!.isEmpty){
                  return "Parolanızı Giriniz..";

                }
                else{
                  return null;
                }
              },
              onSaved: (value){
                username=value!;
              },
            ),
            Row(
              children: <Widget>[
                MaterialButton(child:Text("Giriş"),onPressed: (){})
              ],
            ),
            _loginButton()



          ],
        ),
      ),
      ),
    );
  }

Widget _loginButton() => RaisedButton(child:Text("Giriş Yap"),onPressed: (){
if(_formKey.currentState!.validate()){
  _formKey.currentState!.save();
  if(username=="admin" && password=="password"){
    //diğer sayfaya gitsin
  }

  //debugPrint("username: ", username);
//her şey tamam ise save kısımları çalışır
}
else{

  showDialog(context: context, builder:(BuildContext context){
    return AlertDialog(
      title: Text("Hata"),
      content: Text("Giriş Bilgileriniz Hatalı"),
      actions: <Widget>[
        MaterialButton(child:Text("Geri Dön"),onPressed: ()=>Navigator.pop(context))
      ],
    );

  });
  
}
});
}