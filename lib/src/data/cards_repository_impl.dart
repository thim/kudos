import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:kudos/src/domain/model/card.dart';

import '../domain/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  @override
  Future<void> insert(List<CardModel> values) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("kudos/cards");
    for (CardModel card in values) {
      await ref.push().set(card.toMap());
    }
  }

  @override
  Future<List<CardModel>> load() async {
    final ref = FirebaseDatabase.instance.ref("kudos/cards");
    final snapshot = await ref.get();
    final result = <CardModel>[];
    if (snapshot.exists) {
      final map = snapshot.value;
      if (map is Map) {
        for (Object item in map.values) {
          if (item is Map<String, dynamic>) {
            result.add(CardModel.fromMap(item));
          } else {
            log('Unknown item structure.');
          }
        }
      } else {
        log('Unknown data structure.');
      }
    } else {
      log('No data available.');
    }
    return result;
  }
}
