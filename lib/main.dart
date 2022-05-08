import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kudos/save_file.dart';

void main() {
  runApp(const MyApp());
}

final titles = ['Você arrasou', 'Bom trabalho', 'Foi incrível', 'Parabéns', 'Mandou bem', 'Impressionante'];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

final key = GlobalKey();

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rand = Random();

  var _titleNumber = 0;
  var _imgNumber = 0;

  void _downloadClick() async {
    final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 2.0);
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List() ?? Uint8List.fromList([]);
    FileSaverWeb.downloadFile(imageBytes, "kudo.png", "png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Creator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _imgNumber++;
                        if (_imgNumber >= 4) _imgNumber = 0;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.image),
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _titleNumber++;
                        if (_titleNumber >= titles.length) _titleNumber = 0;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.message),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: key,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xFFFDFDFD)),
                    height: 300,
                    width: 600,
                    child: Stack(children: [
                      Image.asset(
                        'background1.png',
                      ),
                      Positioned(
                        top: 12.0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                          height: 70,
                          alignment: Alignment.center,
                          child: Text(
                            titles[_titleNumber],
                            style: const TextStyle(
                                fontFamily: 'Open Sans', fontWeight: FontWeight.w800, fontSize: 35, color: Color(0xff5c64fe)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: 260,
                          child: Image.asset(
                            'people$_imgNumber.png',
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 200.0, top: 80, right: 8.0),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              style: TextStyle(fontFamily: 'Comic Neue', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                              decoration: InputDecoration(
                                  hintText: "message",
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black38))),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 200.0, top: 8.0, right: 8.0, bottom: 8.0),
                            child: const TextField(
                              style:
                                  TextStyle(fontFamily: 'Comic Neue', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.redAccent),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  hintText: "from",
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.redAccent))),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _downloadClick,
        tooltip: 'Download',
        child: const Icon(Icons.download),
      ),
    );
  }
}
