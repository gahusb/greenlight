import 'package:flutter/material.dart';
import 'package:greenlight/model/bank.dart';
import 'package:sqflite/sqflite.dart';

import 'bankDetailPage.dart';

class BookMarkPage extends StatefulWidget {
  final Future<Database>? db;
  final String? id;

  BookMarkPage({this.db, this.id});

  @override
  State<StatefulWidget> createState() => _BookMarkPage();
}

class _BookMarkPage extends State<BookMarkPage> {

  Future<List<Bank>>? _bankList;
  @override
  void initState() {
    super.initState();
    _bankList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('즐겨찾기'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        List<Bank> bankList = snapshot.data as List<Bank>;
                        Bank info = bankList[index];
                        return Card(
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Hero(
                                    tag: 'bankinfo$index',
                                    child: Container(
                                        margin: EdgeInsets.all(10),
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black, width: 1),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: getImage(info.imagePath))))),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        info.title!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('주소 : ${info.address}'),
                                      info.tel != 'null'
                                          ? Text('전화 번호 : ${info.tel}')
                                          : Container(),
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                  ),
                                  width:
                                  MediaQuery.of(context).size.width - 150,
                                )
                              ],
                            ),
                            onTap: () {
                              // 상세페이지 이동은 TourDetailPage를 재사용하도록 합니다
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BankDetailPage(
                                    bankData: info,
                                    index: index,
                                    id: widget.id,
                                  )));
                            },
                            onDoubleTap: (){
                              deleteBank(widget.db!, info);
                            },
                          ),
                        );
                      },
                      itemCount: (snapshot.data! as List<Bank>).length,
                    );
                  } else {
                    return Text('No data');
                  }
              }
              return CircularProgressIndicator();
            },
            future: _bankList,
          ),
        ),
      ),
    );
  }

  ImageProvider getImage(String? imagePath){
    if(imagePath != null) {
      return NetworkImage(imagePath);
    }else{
      return AssetImage('repo/images/map_location.png');
    }
  }

  void deleteBank(Future<Database> db, Bank info) async {
    final Database database = await db;
    await database.delete('place', where: 'title=?', whereArgs: [info.title]).then((value){
      setState(() {
        _bankList = getTodos();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('즐겨찾기를 해제합니다')));
    });
  }

  Future<List<Bank>> getTodos() async {
    final Database database = await widget.db!;
    final List<Map<String, dynamic>> maps = await database.query('place');

    return List.generate(maps.length, (i) {
      return Bank(
          id: maps[i]['id'],
          title: maps[i]['title'].toString(),
          tel: maps[i]['tel'].toString(),
          zipcode: maps[i]['zipcode'].toString(),
          address: maps[i]['address'].toString(),
          lat: maps[i]['lat'],
          lng: maps[i]['lng'],
          imagePath: maps[i]['imagePath'].toString(),
          organName: maps[i]['organ_name'].toString(),
          organVolumn: maps[i]['organ_volumn'],
      );
    });
  }
}