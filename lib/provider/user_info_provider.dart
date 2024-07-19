import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/model/AddressSelect.dart';
import 'package:wg_pro_002/dao/address_dao.dart';
import 'package:wg_pro_002/dao/dao_result.dart';

class UserInfoProvider extends ChangeNotifier {
  List<AddressSelect>? provinces;
  String? _fullAddress;

  String? get fullAddress => _fullAddress;

  String? selectedProvince;
  String? selectedCity;
  String? selectedArea;

  Future<List<AddressSelect>> fetchProvince(String? id) async {
    DataResult provincesData = await AddressDao.getAddressById(id: id);
    if (provincesData.result) {
      return provincesData.data as List<AddressSelect>;
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  void selectProvince(String province) {
    selectedProvince = province;
    notifyListeners();
  }

  void selectCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void selectArea(String area) {
    selectedArea = area;
    notifyListeners();
  }

  void updateAddress(String province, city, area) {
    this.selectProvince(province);
    this.selectCity(city);
    this.selectArea(area);
    _fullAddress = "$selectedProvince, $selectedCity, $selectedArea";
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
