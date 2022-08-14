abstract class TitlesRepository {
  Future<List<String>> loadAll();

  int get length;
}
