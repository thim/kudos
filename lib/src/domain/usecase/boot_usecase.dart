abstract class BootStep {
  Future<void> init();
}

class BootUseCase {
  Future<void> init(List<BootStep> steps) async {
    for (BootStep step in steps) {
      await step.init();
    }
  }
}
