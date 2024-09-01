import 'package:json_annotation/json_annotation.dart';

part 'UserInfo.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "middle_name")
  String? middleName;
  @JsonKey(name: "current_working_year")
  String? currentWorkingYear;
  @JsonKey(name: "marital_status")
  String? maritalStatus;
  @JsonKey(name: "quantity_of_children")
  String? quantityOfChildren;
  @JsonKey(name: "family_monthly_income")
  String? familyMonthlyIncome;
  @JsonKey(name: "present_address_time")
  String? presentAddressTime;
  @JsonKey(name: "facebook_account")
  String? facebookAccount;
  @JsonKey(name: "birthday")
  String? birthday;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "id_no")
  String? idNo;
  @JsonKey(name: "id_type")
  String? idType;
  @JsonKey(name: "id_no_1")
  String? idNo1;
  @JsonKey(name: "id_type_1")
  String? idType1;
  @JsonKey(name: "job_category")
  String? jobCategory;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "email_1")
  String? email1;
  @JsonKey(name: "education_degree")
  String? educationDegree;
  @JsonKey(name: "family_province")
  String? familyProvince;
  @JsonKey(name: "family_city")
  String? familyCity;
  @JsonKey(name: "family_area")
  String? familyArea;
  @JsonKey(name: "family_detail_address")
  String? familyDetailAddress;
  @JsonKey(name: "present_province")
  String? presentProvince;
  @JsonKey(name: "present_city")
  String? presentCity;
  @JsonKey(name: "is_in_philippines")
  String? isInPhilippines;
  @JsonKey(name: "loan_purpose")
  String? loanPurpose;
  @JsonKey(name: "expected_amount")
  String? expectedAmount;
  @JsonKey(name: "present_area")
  String? presentArea;
  @JsonKey(name: "id_type_desc")
  String? idTypeDesc;
  @JsonKey(name: "present_detail_address")
  String? presentDetailAddress;
  @JsonKey(name: "house_status")
  String? houseStatus;
  @JsonKey(name: "job_desc")
  String? jobDesc;
  @JsonKey(name: "more_id_type_id")
  String? moreIdTypeId;
  @JsonKey(name: "id_type_selected")
  String? idTypeSelected;
  @JsonKey(name: "idcard_front")
  String? idcardFront;
  @JsonKey(name: "idcard_hand")
  String? idcardHand;
  @JsonKey(name: "idcard_hand_switch")
  String? idcardHandSwitch;
  @JsonKey(name: "employment_job_id_list")
  String? employmentJobIdList;
  @JsonKey(name: "id_editable")
  String? idEditable;
  @JsonKey(name: "more_id_type_desc")
  String? moreIdTypeDesc;
  @JsonKey(name: "employment_status")
  String? employmentStatus;
  @JsonKey(name: "company_name")
  String? companyName;
  @JsonKey(name: "company_address")
  String? companyAddress;
  @JsonKey(name: "company_phone")
  String? companyPhone;
  @JsonKey(name: "monthly_income")
  String? monthlyIncome;
  @JsonKey(name: "get_salary_date")
  String? getSalaryDate;
  @JsonKey(name: "get_salary_date_1")
  String? getSalaryDate1;
  @JsonKey(name: "contacter_01_name")
  String? contacter01Name;
  @JsonKey(name: "contacter_01_relationship")
  String? contacter01Relationship;
  @JsonKey(name: "contacter_01_phone")
  String? contacter01Phone;
  @JsonKey(name: "date_on_board")
  String? dateOnBoard;
  @JsonKey(name: "latest_3_months_income")
  String? latest3MonthsIncome;
  @JsonKey(name: "contacter_02_name")
  String? contacter02Name;
  @JsonKey(name: "employee_job_type")
  String? employeeJobType;
  @JsonKey(name: "contacter_02_relationship")
  String? contacter02Relationship;
  @JsonKey(name: "contacter_02_phone")
  String? contacter02Phone;
  @JsonKey(name: "company_province")
  String? companyProvince;
  @JsonKey(name: "company_city")
  String? companyCity;
  @JsonKey(name: "company_area")
  String? companyArea;
  @JsonKey(name: "contact_list")
  List<ContactList>? contactList;
  @JsonKey(name: "contacter_display_count")
  String? contacterDisplayCount;
  @JsonKey(name: "liveness_switch")
  bool? livenessSwitch;
  @JsonKey(name: "liveness_state")
  String? livenessState;
  @JsonKey(name: "liveness_over_limit")
  bool? livenessOverLimit;
  @JsonKey(name: "work_license")
  String? workLicense;
  @JsonKey(name: "income_proof")
  String? incomeProof;
  @JsonKey(name: "picture_display_list")
  List<String>? pictureDisplayList;
  @JsonKey(name: "withdraw_info")
  WithdrawInfo? withdrawInfo;
  @JsonKey(name: "pop_window")
  bool? popWindow;
  @JsonKey(name: "withdraw_tip")
  String? withdrawTip;
  @JsonKey(name: "withdraw_input_tip")
  List<String>? withdrawInputTip;
  @JsonKey(name: "channel_fee")
  ChannelFee? channelFee;
  @JsonKey(name: "options")
  Options? options;

  UserInfo({
    this.firstName,
    this.lastName,
    this.middleName,
    this.currentWorkingYear,
    this.maritalStatus,
    this.quantityOfChildren,
    this.familyMonthlyIncome,
    this.presentAddressTime,
    this.facebookAccount,
    this.birthday,
    this.gender,
    this.idNo,
    this.idType,
    this.idNo1,
    this.idType1,
    this.jobCategory,
    this.email,
    this.email1,
    this.educationDegree,
    this.familyProvince,
    this.familyCity,
    this.familyArea,
    this.familyDetailAddress,
    this.presentProvince,
    this.presentCity,
    this.isInPhilippines,
    this.loanPurpose,
    this.expectedAmount,
    this.presentArea,
    this.idTypeDesc,
    this.presentDetailAddress,
    this.houseStatus,
    this.jobDesc,
    this.moreIdTypeId,
    this.idTypeSelected,
    this.idcardFront,
    this.idcardHand,
    this.idcardHandSwitch,
    this.employmentJobIdList,
    this.idEditable,
    this.moreIdTypeDesc,
    this.employmentStatus,
    this.companyName,
    this.companyAddress,
    this.companyPhone,
    this.monthlyIncome,
    this.getSalaryDate,
    this.getSalaryDate1,
    this.contacter01Name,
    this.contacter01Relationship,
    this.contacter01Phone,
    this.dateOnBoard,
    this.latest3MonthsIncome,
    this.contacter02Name,
    this.employeeJobType,
    this.contacter02Relationship,
    this.contacter02Phone,
    this.companyProvince,
    this.companyCity,
    this.companyArea,
    this.contactList,
    this.contacterDisplayCount,
    this.livenessSwitch,
    this.livenessState,
    this.livenessOverLimit,
    this.workLicense,
    this.incomeProof,
    this.pictureDisplayList,
    this.withdrawInfo,
    this.popWindow,
    this.withdrawTip,
    this.withdrawInputTip,
    this.channelFee,
    this.options,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class ChannelFee {
  @JsonKey(name: "display_list")
  List<DisplayList>? displayList;
  @JsonKey(name: "visible ")
  bool? visible;

  ChannelFee({
    this.displayList,
    this.visible,
  });

  factory ChannelFee.fromJson(Map<String, dynamic> json) =>
      _$ChannelFeeFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelFeeToJson(this);
}

@JsonSerializable()
class DisplayList {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "display_channel_fee")
  String? displayChannelFee;
  @JsonKey(name: "underlined_price")
  String? underlinedPrice;

  DisplayList({
    this.name,
    this.displayChannelFee,
    this.underlinedPrice,
  });

  factory DisplayList.fromJson(Map<String, dynamic> json) =>
      _$DisplayListFromJson(json);

  Map<String, dynamic> toJson() => _$DisplayListToJson(this);
}

@JsonSerializable()
class ContactList {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "relationship")
  String? relationship;

  ContactList({
    this.name,
    this.phone,
    this.relationship,
  });

  factory ContactList.fromJson(Map<String, dynamic> json) =>
      _$ContactListFromJson(json);

  Map<String, dynamic> toJson() => _$ContactListToJson(this);
}

@JsonSerializable()
class Options {
  @JsonKey(name: "job_category_options")
  List<CommonListOption>? jobCategoryOptions;
  @JsonKey(name: "education_degree_options")
  List<CommonListOption>? educationDegreeOptions;
  @JsonKey(name: "gender_options")
  List<CommonListOption>? genderOptions;
  @JsonKey(name: "id_type_options")
  List<IdTypeOption>? idTypeOptions;
  @JsonKey(name: "id_type_1_options")
  List<CommonListOption>? idType1Options;
  @JsonKey(name: "marital_status_options")
  List<CommonListOption>? maritalStatusOptions;
  @JsonKey(name: "quantity_of_children_options")
  List<CommonListOption>? quantityOfChildrenOptions;
  @JsonKey(name: "current_working_year_options")
  List<CommonListOption>? currentWorkingYearOptions;
  @JsonKey(name: "family_monthly_income_options")
  List<CommonListOption>? familyMonthlyIncomeOptions;
  @JsonKey(name: "present_address_time_options")
  List<CommonListOption>? presentAddressTimeOptions;
  @JsonKey(name: "house_status_options")
  List<CommonListOption>? houseStatusOptions;
  @JsonKey(name: "loan_purpose_options")
  List<CommonListOption>? loanPurposeOptions;
  @JsonKey(name: "is_in_philippines")
  List<CommonListOption>? isInPhilippines;
  @JsonKey(name: "latest_3_months_income_options")
  List<CommonListOption>? latest3MonthsIncomeOptions;
  @JsonKey(name: "contacter_01_relationship")
  List<CommonListOption>? contacter01Relationship;
  @JsonKey(name: "contacter_02_relationship")
  List<CommonListOption>? contacter02Relationship;
  @JsonKey(name: "employment_status_options")
  List<CommonListOption>? employmentStatusOptions;
  @JsonKey(name: "employee_job_type_options")
  List<CommonListOption>? employeeJobTypeOptions;
  @JsonKey(name: "job_category_options_01")
  List<CommonListOption>? jobCategoryOptions01;
  @JsonKey(name: "job_category_options_02")
  List<CommonListOption>? jobCategoryOptions02;
  @JsonKey(name: "monthly_income_options")
  List<CommonListOption>? monthlyIncomeOptions;
  @JsonKey(name: "withdraw_channel_options")
  List<WithdrawChannelOption>? withdrawChannelOptions;

  Options({
    this.jobCategoryOptions,
    this.educationDegreeOptions,
    this.genderOptions,
    this.idTypeOptions,
    this.idType1Options,
    this.maritalStatusOptions,
    this.quantityOfChildrenOptions,
    this.currentWorkingYearOptions,
    this.familyMonthlyIncomeOptions,
    this.presentAddressTimeOptions,
    this.houseStatusOptions,
    this.loanPurposeOptions,
    this.isInPhilippines,
    this.latest3MonthsIncomeOptions,
    this.contacter01Relationship,
    this.contacter02Relationship,
    this.employmentStatusOptions,
    this.employeeJobTypeOptions,
    this.jobCategoryOptions01,
    this.jobCategoryOptions02,
    this.monthlyIncomeOptions,
    this.withdrawChannelOptions,
  });

  factory Options.fromJson(Map<String, dynamic> json) =>
      _$OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsToJson(this);
}

@JsonSerializable()
class CommonListOption {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "value")
  String? value;

  CommonListOption({
    this.id,
    this.value,
  });

  // 通过键来访问属性的操作符重载
  operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'value':
        return value;
      default:
        throw ArgumentError('Property $key not found');
    }
  }

  factory CommonListOption.fromJson(Map<String, dynamic> json) =>
      _$CommonListOptionFromJson(json);

  Map<String, dynamic> toJson() => _$CommonListOptionToJson(this);
}

@JsonSerializable()
class IdTypeOption {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "value")
  String? value;
  @JsonKey(name: "recommend")
  String? recommend;

  IdTypeOption({
    this.id,
    this.value,
    this.recommend,
  });

  factory IdTypeOption.fromJson(Map<String, dynamic> json) =>
      _$IdTypeOptionFromJson(json);

  Map<String, dynamic> toJson() => _$IdTypeOptionToJson(this);
}

@JsonSerializable()
class WithdrawChannelOption {
  @JsonKey(name: "channel_name")
  String? channelName;
  @JsonKey(name: "require_account_no")
  bool? requireAccountNo;

  WithdrawChannelOption({
    this.channelName,
    this.requireAccountNo,
  });

  factory WithdrawChannelOption.fromJson(Map<String, dynamic> json) =>
      _$WithdrawChannelOptionFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawChannelOptionToJson(this);
}

@JsonSerializable()
class WithdrawInfo {
  @JsonKey(name: "withdraw_channel")
  String? withdrawChannel;
  @JsonKey(name: "withdraw_account_no")
  String? withdrawAccountNo;
  @JsonKey(name: "withdraw_account_name")
  String? withdrawAccountName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "withdraw_first_name")
  String? withdrawFirstName;
  @JsonKey(name: "withdraw_last_name")
  String? withdrawLastName;
  @JsonKey(name: "withdraw_middle_name")
  String? withdrawMiddleName;
  @JsonKey(name: "client_type")
  String? clientType;

  WithdrawInfo({
    this.withdrawChannel,
    this.withdrawAccountNo,
    this.withdrawAccountName,
    this.email,
    this.withdrawFirstName,
    this.withdrawLastName,
    this.withdrawMiddleName,
    this.clientType,
  });

  factory WithdrawInfo.fromJson(Map<String, dynamic> json) =>
      _$WithdrawInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawInfoToJson(this);
}
