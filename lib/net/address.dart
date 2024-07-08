class Address {
  static const String host = "http://47.99.110.145";

  static getLogin() {
    return "${host}/philippines_loan/user/login";
  }

  static getPageIndex() {
    return "${host}/philippines_loan/user/get_user_info";
  }

  static getUserInfo() {
    return "${host}/philippines_loan/user/get_user_detail_info";
  }

  static getRegionList() {
    return "${host}/philippines_loan/user/get_region_list";
  }
}
