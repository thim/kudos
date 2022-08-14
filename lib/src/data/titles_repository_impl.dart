import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import '../domain/titles_repository.dart';

class TitlesRepositoryImpl implements TitlesRepository {
  final _titles = <String>[];

  @override
  Future<List<String>> loadAll() async {
    final ref = FirebaseDatabase.instance.ref("kudos/titles");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final list = snapshot.value;
      if (list is List) {
        for (Object item in list) {
          if (item is String) {
            _titles.add(item);
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
    return _titles;
  }

  @override
  int get length => _titles.length;
}
