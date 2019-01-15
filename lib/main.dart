import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: uygulamaGovdesi(),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //STATIC FORMU TUTAN CONTAINER
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.pink.shade200,
            child: Form(
                child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ders Adı",
                    hintText: "Ders adını giriniz",
                    hintStyle: TextStyle(fontSize: 18),
                    labelStyle: TextStyle(fontSize: 22),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (girilenDeger) {
                    if (girilenDeger.length > 0) {
                      return null;
                    } else
                      return "Ders adı boş olamaz";
                  },
                  onSaved: (kaydedilecekDeger) {
                    dersAdi = kaydedilecekDeger;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: DropdownButton<int>(
                        items: dersKredileriItems(),
                        value: dersKredi,
                        onChanged: (secilenKredi) {
                          setState(() {
                            dersKredi = secilenKredi;
                          });
                        },
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    Container(
                      child: DropdownButton<double>(
                        items: dersHarfDegerleriItems(),
                        value: dersHarfDegeri,
                        onChanged: (secilenHarf) {
                          setState(() {
                            dersHarfDegeri = secilenHarf;
                          });
                        },
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ],
                ),
                Divider(color: Colors.blue, height: 40, indent: 2,),
              ],
            )),
          )),

          //DINAMIK LISTE TUTAN CONTAINER
          Expanded(
              child: Container(
            color: Colors.green.shade200,
            child: Text("Liste"),
          )),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
//     var aa = DropdownMenuItem<int>(value: i, child: Text("$i Kredi"),)
//     krediler.add(aa);
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(fontSize: 30),
        ),
      ));
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(
        " AA ",
        style: TextStyle(fontSize: 30),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 30),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 30),
      ),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 30),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 30),
      ),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 30),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 30),
      ),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FF ",
        style: TextStyle(fontSize: 30),
      ),
      value: 0,
    ));

    return harfler;
  }
}
