import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenlight/model/opinion.dart';
import 'dart:math' as math;

import '../model/bank.dart';

class BankDetailPage extends StatefulWidget {
  final Bank? bankData;
  final int? index;

  final String? id;

  BankDetailPage({this.bankData, this.index, this.id});

  @override
  State<StatefulWidget> createState() => _BankDetailPage();
}

class _BankDetailPage extends State<BankDetailPage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  CameraPosition? _GoogleMapCamera;
  TextEditingController? _opinionTextController;
  Marker? marker;
  List<Opinion> opinions = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    _opinionTextController = TextEditingController();
    _GoogleMapCamera = CameraPosition(
      target: LatLng(double.parse(widget.bankData!.lng.toString()),
          double.parse(widget.bankData!.lat.toString())),
      zoom: 16,
    );
    MarkerId markerId = MarkerId(widget.bankData.hashCode.toString());
    marker = Marker(
        position: LatLng(double.parse(widget.bankData!.lng.toString()),
            double.parse(widget.bankData!.lat.toString())),
        flat: true,
        markerId: markerId);
    markers[markerId] = marker!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${widget.bankData!.title}',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 10),
            ),
            pinned: true,
            backgroundColor: Colors.deepOrangeAccent,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Hero(
                            tag: 'tourinfo${widget.index}',
                            child: Container(
                                width: 300.0,
                                height: 300.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                    Border.all(color: Colors.black, width: 1),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: getImage(
                                          widget.bankData!.imagePath)
                                      ,)))),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            widget.bankData!.address!,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        getGoogleMap(),
                        //  reviewWidget()
                      ],
                    ),
                  ),
                ),
              ])),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 100,
                child: Container(
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '의견',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Card(
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Text(
                        '${opinions[index].id} : ${opinions[index].opinion}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    onDoubleTap: () {
                      if (opinions[index].id == widget.id) {
                        // widget.databaseReference!
                        //     .child('bank')
                        //     .child(widget.bankData!.id.toString())
                        //     .child('opinion').child(widget.id!)
                        //     .remove();
                        setState(() {
                          opinions.removeAt(index);
                        });
                      }
                    },
                  ),
                );
              }, childCount: opinions.length)),
          SliverList(
              delegate: SliverChildListDelegate([
                MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('의견 남기기'),
                            content: TextField(
                              controller: _opinionTextController,
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                  onPressed: () {
                                    // Opinion opinion = Opinion(
                                    //     widget.id!,
                                    //     _opinionTextController!.value.text,
                                    //     DateTime.now().toIso8601String());
                                    // widget.databaseReference!
                                    //     .child('bank')
                                    //     .child(widget.bankData!.id.toString())
                                    //     .child('opinion').child(widget.id!)
                                    //     .set(opinion.toJson());
                                  },
                                  child: Text('의견 남기기')),
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('종료하기')),
                            ],
                          );
                        });
                  },
                  child: Text('쓰기'),
                )
              ]))
        ],
      ),
    );
  }

  ImageProvider getImage(String? imagePath) {
    if (imagePath != null) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage('repo/images/map_location.png');
    }
  }

  getGoogleMap() {
    return SizedBox(
      height: 400,
      width: MediaQuery
          .of(context)
          .size
          .width - 50,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _GoogleMapCamera!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(markers.values)),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double? maxHeight;
  final Widget? child;

  _HeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

  @override
  double get minExtent => minHeight!;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}