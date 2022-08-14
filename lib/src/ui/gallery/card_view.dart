import 'package:flutter/material.dart';

import '../../domain/model/card.dart';
import '../../theme.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key, required this.model}) : super(key: key);

  final CardModel model;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                model.title,
                style: AppFontStyle.h1().bold.withColor(AppColors.cardTitleColor).build(),
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 80,
            child: SizedBox(
              width: 380,
              child: Text(
                model.message,
                style: AppFontStyle.p1().bold.withFamily('Comic Neue').withColor(AppColors.textColor).build(),
              ),
            ),
          ),
          Positioned(
            right: 24.0,
            bottom: 24.0,
            child: Text(
              model.from,
              style: AppFontStyle.p1().bold.withFamily('Comic Neue').withColor(AppColors.textColor).build(),
              textAlign: TextAlign.end,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              width: 260,
              child: Image.asset(
                model.asset,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
