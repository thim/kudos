import '../../data/cards_repository_impl.dart';
import '../../data/titles_repository_impl.dart';
import '../../domain/model/card.dart';
import '../ui_base.dart';

class CreateState {}

class CreateLoadingState implements CreateState {}

class CreateDataState implements CreateState {
  List<String> titles;
  CreateDataState(this.titles);
}

class CreatePresenter extends PresenterBase<CreateState> {
  final _cardRepo = CardsRepositoryImpl();
  final _titlesRepo = TitlesRepositoryImpl();

  Future<void> load() async {
    emit(CreateLoadingState());
    await Future.delayed(const Duration(milliseconds: 200));
    final titles = await _titlesRepo.loadAll();
    emit(CreateDataState(titles));
  }

  Future<bool> save(String from, String title, String message, String asset) async {
    final card = CardModel(date: DateTime.now(), from: from, message: message, title: title, asset: asset);
    _cardRepo.insert([card]);
    return true;
  }
}
