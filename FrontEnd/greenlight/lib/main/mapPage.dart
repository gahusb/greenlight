import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../data/listData.dart';
import '../model/bank.dart';
import 'bankDetailPage.dart';


class MapPage extends StatefulWidget {
  final Future<Database>? db; // DB 연동
  final String? id; // 로그인한 아이디
  // MapPage({this.databaseReference, this.db, this.id});
  MapPage({this.db, this.id});

  @override
  State<StatefulWidget> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  List<DropdownMenuItem<Item>> list = List.empty(growable: true);
  List<DropdownMenuItem<Item>> sublist = List.empty(growable: true);
  List<Bank> bankData = List.empty(growable: true);
  ScrollController? _scrollController;
  String authKey = 'AIzaSyB9gKXgezheyqhb6WIrb-NJ-rkIcy5dmws';
  Item? area;
  Item? kind;
  int page = 1;

  @override
  void initState() {
    super.initState();
    list = Area().seoulArea;
    sublist = Kind().kinds;
    area = list[0].value;
    kind = sublist[0].value;
    _scrollController = new ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
          _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        page++;
        getAreaList(area: area!.value, contentTypeId: kind!.value, page: page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색하기'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  DropdownButton<Item>(
                    value: area,
                    onChanged: (value) {
                      Item selectedItem = value!;
                      setState(() {
                        area = selectedItem;
                      });
                    },
                    items: list,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<Item>(
                    items: sublist,
                    onChanged: (value) {
                      Item selectedItem = value!;
                      setState(() {
                        kind = selectedItem;
                      });
                    },
                    value: kind,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      page = 1;
                      bankData.clear();
                      getAreaList(
                          area: area!.value,
                          contentTypeId: kind!.value,
                          page: page);
                    },
                    child: Text(
                      '검색하기',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
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
                                              image: getImage(
                                                  bankData[index].imagePath))))),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      bankData[index].title!,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('주소 : ${bankData[index].address}'),
                                    bankData[index].tel != null
                                        ? Text('전화 번호 : ${bankData[index].tel}')
                                        : Container(),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                                width: MediaQuery.of(context).size.width - 150,
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BankDetailPage(
                                  bankData: bankData[index],
                                  index: index,
                                  id: widget.id,
                                )));
                          },
                          onDoubleTap: () {
                            insertBank(widget.db!, bankData[index]);
                          },
                        ),
                      );
                    },
                    itemCount: bankData.length,
                    controller: _scrollController,
                  ))
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  void insertBank(Future<Database> db, Bank info) async {
    final Database database = await db;
    await database
        .insert('place', info.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('즐겨찾기에 추가되었습니다')));
    });
  }

  ImageProvider getImage(String? imagePath) {
    if (imagePath != null) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage('repo/images/map_location.png');
    }
  }

  void getAreaList(
      {required int area,
        required int contentTypeId,
        required int page}) async {
    var url =
        'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey='
        '$authKey&MobileOS=AND&MobileApp=ModuTour&_type=json&areaCode=1&numOfRows=10&sigunguCode='
        '$area&pageNo=$page';
    if (contentTypeId != 0) {
      url = url + '&contentTypeId=$contentTypeId';
    }
    print(url);
    var response = await http.get(Uri.parse(url));
    String body = utf8.decode(response.bodyBytes);
    print(body);
    var json = jsonDecode(body);
    if (json['response']['header']['resultCode'] == "0000") {
      if (json['response']['body']['items'] == '') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('마지막 데이터 입니다'),
              );
            });
      } else {
        List jsonArray = json['response']['body']['items']['item'];
        for (var s in jsonArray) {
          setState(() {
            bankData.add(Bank.fromJson(s));
          });
        }
      }
    } else {
      print('error');
    }
  }
}