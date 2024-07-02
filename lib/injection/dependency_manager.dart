import 'data_modules.dart';
import 'injector.dart';

class DependencyManager {
  static Future<void> inject() async {
    ///Inject data modules
    DataModules.inject();

    /// Waiting all modules injected
    await injector.allReady();
  }
}
