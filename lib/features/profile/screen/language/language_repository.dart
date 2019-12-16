import 'package:wmn_plus/features/profile/screen/language/index.dart';
import 'package:wmn_plus/util/config.dart';

class LanguageRepository {
  final LanguageProvider _languageProvider = LanguageProvider();

  LanguageRepository();

  void test(bool isError) {
    this._languageProvider.test(isError);
  }

  Future<HttpStatus> changeLanguage(LanguageType type) async {
    return await this._languageProvider.changeLanguageRequest(type);
  }
}
