import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.purple),
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
  List<Ders> tumDersler;
  static int sayac = 0;

  var formKey = GlobalKey<FormState>();
  double ortalama = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return uygulamaGovdesi();
        } else {
          return uygulamaGovdesiLandscape();
        }
      }),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //STATIC FORMU TUTAN CONTAINER
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //color: Colors.pink.shade200,
            child: Form(
              key: formKey,
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
                      setState(() {
                        tumDersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi,
                            rastgeleRenkOlustur()));
                        ortalama = 0;
                        ortalamayiHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKredileriItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: dersHarfDegeri,
                            onChanged: (secilenHarf) {
                              setState(() {
                                dersHarfDegeri = secilenHarf;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: BorderDirectional(
                  top: BorderSide(color: Colors.blue, width: 2),
                  bottom: BorderSide(color: Colors.blue, width: 2),
                )),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: tumDersler.length == 0
                            ? " Lütfen ders ekleyin "
                            : "Ortalama : ",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    TextSpan(
                        text: tumDersler.length == 0
                            ? ""
                            : "${ortalama.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),

          //DINAMIK LISTE TUTAN CONTAINER
          Expanded(
              child: Container(
                  child: ListView.builder(
            itemBuilder: _listeElemanlariniOlustur,
            itemCount: tumDersler.length,
          ))),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //color: Colors.pink.shade200,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ders Adı",
                          hintText: "Ders adını giriniz",
                          hintStyle: TextStyle(fontSize: 18),
                          labelStyle: TextStyle(fontSize: 22),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2),
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
                          setState(() {
                            tumDersler.add(Ders(dersAdi, dersHarfDegeri,
                                dersKredi, rastgeleRenkOlustur()));
                            ortalama = 0;
                            ortalamayiHesapla();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                items: dersKredileriItems(),
                                value: dersKredi,
                                onChanged: (secilenKredi) {
                                  setState(() {
                                    dersKredi = secilenKredi;
                                  });
                                },
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.purple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<double>(
                                items: dersHarfDegerleriItems(),
                                value: dersHarfDegeri,
                                onChanged: (secilenHarf) {
                                  setState(() {
                                    dersHarfDegeri = secilenHarf;
                                  });
                                },
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.purple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: BorderDirectional(
                        top: BorderSide(color: Colors.blue, width: 2),
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      )),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: tumDersler.length == 0
                                  ? " Lütfen ders ekleyin "
                                  : "Ortalama : ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          TextSpan(
                              text: tumDersler.length == 0
                                  ? ""
                                  : "${ortalama.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemBuilder: _listeElemanlariniOlustur,
              itemCount: tumDersler.length,
            ),
          ),
        ),
      ],
    ));
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
          style: TextStyle(fontSize: 20),
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
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FF ",
        style: TextStyle(fontSize: 20),
      ),
      value: 0,
    ));

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    debugPrint(sayac.toString());

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: tumDersler[index].renk, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(
            Icons.done,
            size: 36,
            color: tumDersler[index].renk,
          ),
          title: Text(tumDersler[index].ad),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: tumDersler[index].renk,
          ),
          subtitle: Text(tumDersler[index].kredi.toString() +
              " kredi Ders Not Değer: " +
              tumDersler[index].harfDegeri.toString()),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oankiDers in tumDersler) {
      var kredi = oankiDers.kredi;
      var harfDegeri = oankiDers.harfDegeri;

      toplamNot = toplamNot + (harfDegeri * kredi);
      toplamKredi += kredi;
    }

    ortalama = toplamNot / toplamKredi;
  }

  Color rastgeleRenkOlustur() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Color renk;

  Ders(this.ad, this.harfDegeri, this.kredi, this.renk);
}
