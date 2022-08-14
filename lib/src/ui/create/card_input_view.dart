import 'package:flutter/material.dart';

import '../../theme.dart';

class CardController {
  final TextEditingController msgController = TextEditingController();
  final TextEditingController fromController = TextEditingController();

  String get message => msgController.text;

  String get from => fromController.text;

  void dispose() {
    msgController.dispose();
    fromController.dispose();
  }
}

class CardInputView extends StatelessWidget {
  const CardInputView({
    Key? key,
    required String title,
    required String img,
    CardController? controller,
  })  : _title = title,
        _img = img,
        _controller = controller,
        super(key: key);

  final String _title;
  final String _img;
  final CardController? _controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: const BoxDecoration(color: AppColors.cardColor),
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
                _title,
                style: const TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w800, fontSize: 35, color: AppColors.cardTitleColor),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              width: 260,
              child: Image.asset(
                _img,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 200.0, top: 80, right: 8.0),
                child: TextField(
                  controller: _controller?.msgController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  style: const TextStyle(fontFamily: 'Comic Neue', fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textColor),
                  decoration: const InputDecoration(
                    hintText: "message",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 200.0, top: 8.0, right: 8.0, bottom: 8.0),
                child: TextField(
                  controller: _controller?.fromController,
                  style: const TextStyle(fontFamily: 'Comic Neue', fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.imperialRed),
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    hintText: "from",
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
