import 'model/card.dart';

abstract class CardsRepository {
  Future<List<CardModel>> load();

  Future<void> insert(List<CardModel> values);
}
