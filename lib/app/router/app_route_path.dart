class AppRoutePath {
  final bool isHomePage;
  final int? id;

  AppRoutePath.home() : isHomePage = true, id = null;
  AppRoutePath.details(this.id) : isHomePage = false;
  AppRoutePath.settings() : isHomePage = false, id = null;
}
