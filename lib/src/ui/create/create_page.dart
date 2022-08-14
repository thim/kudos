import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kudos/src/ui/create/create_presenter.dart';
import 'package:kudos/src/ui/save_file.dart';

import '../../theme.dart';
import 'card_input_view.dart';

final key = GlobalKey();

class CreatePage extends StatefulWidget {
  const CreatePage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final rand = Random();

  var _titleNumber = 0;
  var _imgNumber = 0;

  final _controller = CardController();
  final _presenter = CreatePresenter();

  void _downloadClick() async {
    final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 2.0);
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List() ?? Uint8List.fromList([]);
    FileSaverWeb.downloadFile(imageBytes, "kudo.png", "png");
  }

  void _click(String title) async {
    if (_controller.message.isEmpty || _controller.from.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Adicione uma mensagem e um autor antes de salvar.'),
      ));
      return;
    }

    final result = await _presenter.save(_controller.from, title, _controller.message, 'people$_imgNumber.png');

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Salvo com sucesso.'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _presenter.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CreateState>(
        stream: _presenter.state,
        builder: (context, snapshot) {
          final currentState = snapshot.data;
          if (currentState is CreateDataState) {
            return _createLoadedState(currentState.titles);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createLoadedState(List<String> titles) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Card Creator', style: AppFontStyle.custom(60).semiBold.withColor(AppColors.titleColor).build()),
            const SizedBox(
              height: 48.0,
            ),
            RepaintBoundary(
              key: key,
              child: CardInputView(
                title: titles[_titleNumber],
                img: 'people$_imgNumber.png',
                controller: _controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
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
                  const SizedBox(
                    width: 24.0,
                  ),
                  ElevatedButton(
                      onPressed: _downloadClick,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.download),
                      )),
                  const SizedBox(
                    width: 8.0,
                  ),
                  ElevatedButton(
                      onPressed: () => _click(titles[_titleNumber]),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.cloud_upload),
                      )),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _click,
        //   tooltip: 'Save',
        //   child: const Icon(Icons.download),
        // ),
      );
}
