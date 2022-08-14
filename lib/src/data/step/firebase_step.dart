import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../firebase_options.dart';
import '../../domain/usecase/boot_usecase.dart';

class FirebaseConnect implements BootStep {
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  }
}
