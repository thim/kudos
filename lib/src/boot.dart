import 'package:kudos/src/data/step/firebase_step.dart';
import 'package:kudos/src/domain/usecase/boot_usecase.dart';

Future<void> boot() async {
  final boot = BootUseCase();
  await boot.init([FirebaseConnect()]);
}
