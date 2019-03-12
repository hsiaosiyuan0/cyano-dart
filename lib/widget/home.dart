import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'asset.dart';
import 'holder.dart';
import 'setting.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeWidget> {
  int _curIdx = 0;
  final List<Widget> _children = [
    AssetWidget(),
    HolderWidget(Colors.deepOrange),
    SettingWidget()
  ];

  Future<void> _scan() async {
    String barcode = await BarcodeScanner.scan();
    print(barcode);
  }

  @override
  Widget build(BuildContext context) {
    var constraints = const BoxConstraints(minWidth: 48.0, minHeight: 48.0);
    var iconSize = 28.0;
    var padding = const EdgeInsets.only(right: 15.0);
    var radius = math.max(
      Material.defaultSplashRadius,
      (iconSize + math.min(padding.horizontal, padding.vertical)) * 0.7,
      // x 0.5 for diameter -> radius and + 40% overflow derived from other Material apps.
    );

    return Scaffold(
      appBar: new AppBar(
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: Center(
                child: Image.asset(
              'graphics/logo_white.png',
              width: 30,
            )),
          ),
          actions: <Widget>[
            InkResponse(
                onTap: () {
                  _scan();
                },
                child: ConstrainedBox(
                  constraints: constraints,
                  child: Padding(
                    padding: padding,
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Align(
                          alignment: Alignment.center,
                          child: Ink.image(
                            padding: const EdgeInsets.all(8.0),
                            image: AssetImage('graphics/icon_scan_qr.png'),
                            fit: BoxFit.contain,
                            width: iconSize,
                            height: iconSize,
                          )),
                    ),
                  ),
                ),
                radius: radius),
          ],
          automaticallyImplyLeading: false),
      body: _children[_curIdx],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            _curIdx = idx;
          });
        },
        currentIndex: _curIdx, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'graphics/tab_asset_un_selected.png',
              width: 25,
            ),
            activeIcon: Image.asset(
              'graphics/tab_asset_selected.png',
              width: 25,
            ),
            title: Text(
              'Asset',
              style: TextStyle(color: const Color(0xFF06244e), fontSize: 13.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'graphics/tab_game_unselect.png',
              width: 25,
            ),
            activeIcon: Image.asset(
              'graphics/tab_game_select.png',
              width: 25,
            ),
            title: Text(
              'DApp',
              style: TextStyle(color: const Color(0xFF06244e), fontSize: 13.0),
            ),
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'graphics/tab_me_un_selected.png',
                width: 25,
              ),
              activeIcon: Image.asset(
                'graphics/tab_me_selected.png',
                width: 25,
              ),
              title: Text(
                'Setting',
                style:
                    TextStyle(color: const Color(0xFF06244e), fontSize: 13.0),
              ))
        ],

        fixedColor: Color(0xff6E6F70),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
