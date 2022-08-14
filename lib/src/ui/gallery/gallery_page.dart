import 'package:flutter/material.dart';
import 'package:kudos/src/domain/model/card.dart';
import 'package:kudos/src/ui/gallery/gallery_presenter.dart';

import '../../theme.dart';
import 'card_view.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final _controller = PageController(viewportFraction: 0.8);
  final _presenter = GalleryPresenter();

  @override
  void initState() {
    super.initState();
    _presenter.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: StreamBuilder<List<CardModel>>(
          stream: _presenter.data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: _presenter.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = snapshot.data![index];
                      return _buildView(context, data, index, _presenter.length);
                    },
                  ),
                  Positioned(
                    bottom: 48.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _controller.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.navigate_before),
                            )),
                        const SizedBox(
                          width: 24.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.navigate_next),
                            ))
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _buildView(BuildContext context, CardModel cardModel, int index, int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardView(model: cardModel),
            const SizedBox(
              height: 24.0,
            ),
            Text('${index + 1} / $length', style: AppFontStyle.p1().semiBold.withColor(AppColors.honeydew).build()),
          ],
        ),
      ),
    );
  }
}
