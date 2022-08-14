import 'dart:async';

import '../../data/cards_repository_impl.dart';
import '../../domain/model/card.dart';

class GalleryPresenter {
  final _data = StreamController<List<CardModel>>.broadcast();
  Stream<List<CardModel>> get data => _data.stream;

  final _repo = CardsRepositoryImpl();
  final _list = <CardModel>[];

  int get length => _list.length;

  Future<void> load() async {
    final cards = await _repo.load();
    _list.addAll(cards);
    _data.add(_list);
  }

  CardModel getCard(int index) => _list[index];
}
