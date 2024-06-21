class Config {
  static bool? DEBUG = true;

  static const PAGE_SIZE = 20;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static const API_TOKEN = "4d65e2a5626103f92a71867d7b49fea0";
  static const TOKEN_KEY = "token";
  static const USER_NAME_KEY = "user-name";
  static const PW_KEY = "user-pw";
  static const USER_BASIC_CODE = "user-basic-code";
  static const USER_INFO = "user-info";
  static const LANGUAGE_SELECT = "language-select";
  static const LANGUAGE_SELECT_NAME = "language-select-name";
  static const REFRESH_LANGUAGE = "refreshLanguageApp";
  static const THEME_COLOR = "theme-color";
  static const LOCALE = "locale";

  static const APP_NAME_KEY = 'app-name';
  static const APP_VERSION_KEY = 'app-version';
  static const API_VERSION_KEY = 'api-version';

  String appName = "Prima Loan";
  String clientVersion = "1.9.9";
  String apiVersion = "1.5";

  void setAppName(String name) {
    appName = name;
  }

  static final Config _singleton = Config._internal();

  factory Config() {
    return _singleton;
  }

  Config._internal();
}
