import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/model/AddressSelect.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/dao/address_dao.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/utils/camera_utils.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInfo? _userInfo;
  UserInfo? get userInfo => _userInfo;
  Future<List<CommonListOption>>? _genderOptionsFuture;
  Future<List<CommonListOption>>? get genderOptionsFuture =>
      _genderOptionsFuture;
  Future<List<CommonListOption>>? _maritalStatusOptionsFuture;
  Future<List<CommonListOption>>? get maritalStatusOptionsFuture =>
      _maritalStatusOptionsFuture;
  Future<List<CommonListOption>>? _edutionDegreeOptionsFuture;
  Future<List<CommonListOption>>? get edutionDegreeOptionsFuture =>
      _edutionDegreeOptionsFuture;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool _isDataLoaded = false; // 标志位，避免重复加载

  List<AddressSelect>? provinces;
  String? _fullAddress;
  String? get fullAddress => _fullAddress;

  String _idNo = "";
  String get idNo => _idNo;

  String _firstName = "";
  String get firstName => _firstName;

  String _middleName = "";
  String get middleName => _middleName;

  String _lastName = "";
  String get lastName => _lastName;

  String _gender = "";
  String get gender => _gender;
  String _genderId = "";
  String get genderId => _genderId;

  String _educationDegreeId = "";
  String get educationDegreeId => _educationDegreeId;

  String _educationDegree = "";
  String get educationDegree => _educationDegree;

  String _maritalStatus = "";
  String get maritalStatus => _maritalStatus;
  String _maritalStatusId = "";
  String get maritalStatusId => _maritalStatusId;

  String? selectedProvince;
  String? selectedCity;
  String? selectedArea;

  final CameraUtils _cameraUtil = CameraUtils();
  bool isUploading = false;
  String? imagePath01;
  String? imagePath02;
  bool isUploading01 = false;
  bool isUploading02 = false;

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
    selectProvince(province);
    selectCity(city);
    selectArea(area);
    _fullAddress = "$selectedProvince, $selectedCity, $selectedArea";
    notifyListeners();
  }

  void setIdNo(String newIdNo) {
    if (_idNo != newIdNo) {
      _idNo = newIdNo;
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  void setFirstName(String newValue) {
    if (_firstName != newValue) {
      _firstName = newValue;
      if (kDebugMode) {
        print("first name hhhh");
      }
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  void setMiddleName(String newValue) {
    if (_middleName != newValue) {
      _middleName = newValue;
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  void setLastName(String newValue) {
    if (_lastName != newValue) {
      _lastName = newValue;
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  void setGender(String newGenderId, newValue) {
    if (_gender != newValue) {
      _gender = newValue;
      _genderId = newGenderId;
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  void setEducationDegree(String newEducationId, newValue) {
    if (_educationDegree != newValue) {
      _educationDegree = newValue;
      _educationDegreeId = newEducationId;
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  void setMaritalStatus(String newMaritalStatusId, newValue) {
    if (_maritalStatus != newValue) {
      _maritalStatus = newValue;
      _maritalStatusId = newMaritalStatusId;
      notifyListeners(); // 通知所有监听者，状态已改变
    }
  }

  Future<void> loadUserData() async {
    if (_isDataLoaded) return; // 如果数据已加载，直接返回
    _isLoading = true;
    notifyListeners();

    DataResult res = await UserDao.getUserInfo();
    if (res.result && res.data is UserInfo) {
      _userInfo = res.data as UserInfo;
      _isDataLoaded = true;
      _genderOptionsFuture =
          Future.value(_userInfo?.options?.genderOptions ?? []);
      _maritalStatusOptionsFuture =
          Future.value(userInfo?.options?.maritalStatusOptions ?? []);
      _edutionDegreeOptionsFuture =
          Future.value(userInfo?.options?.educationDegreeOptions ?? []);
      _gender = userInfo?.gender ?? '';
      _maritalStatus = userInfo?.maritalStatus ?? '';

      _isLoading = false;

      notifyListeners(); // 数据加载成功，通知更新
    } else {
      _isLoading = false;
    }
  }

  Future<void> ensureCameraInitialized(bool useFrontCamera) async {
    if (_cameraUtil.controller == null ||
        !_cameraUtil.controller!.value.isInitialized) {
      await _cameraUtil.initCamera(useFrontCamera);
      notifyListeners(); // Notify to rebuild any widgets that depend on the camera
    }
  }

  Future<void> takeAndUploadPicture({int imageIndex = 0}) async {
    String? imagePath = await _cameraUtil.takePicture();

    if (imagePath != null) {
      if (imageIndex == 0) {
        imagePath01 = imagePath;
        isUploading01 = true;
      } else if (imageIndex == 1) {
        imagePath02 = imagePath;
        isUploading02 = true;
      } else {
        throw Exception('image index exception');
      }

      isUploading = true;
      notifyListeners();

      // Simulate an upload process
      await Future.delayed(const Duration(seconds: 2));

      if (imageIndex == 0) {
        isUploading01 = false;
      } else if (imageIndex == 1) {
        isUploading02 = false;
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cameraUtil.dispose();
    super.dispose();
  }
}
