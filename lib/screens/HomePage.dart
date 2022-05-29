//login olacak 2. sayfaya yönlendir.
import 'package:flutter/material.dart';

import 'adminindex.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Doğrulama Denemesi';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String adi = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (deger) {
              if (deger!.isEmpty) {
                return "Lütfen kullanıcı adı giriniz.";
              }
              adi= deger;
              return null;
            },
          ),
          TextFormField(
            validator: (deger) {
              if (deger!.length < 8) {
                return "Lütfen kullanıcı daha uzun bir şifre giriniz.";
              }
              password= deger;
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("Kullanıcı kaydı yapılıyor.");
                print(adi);
                print(password);
                if(password =="admin1234" && adi =="admin"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MySecondPage()));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));

                }

              }
            },
            child: Text('Onayla'),
          )
        ],
      ),
    );
  }
}