// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      middleName: json['middle_name'] as String?,
      currentWorkingYear: json['current_working_year'] as String?,
      maritalStatus: json['marital_status'] as String?,
      quantityOfChildren: json['quantity_of_children'] as String?,
      familyMonthlyIncome: json['family_monthly_income'] as String?,
      presentAddressTime: json['present_address_time'] as String?,
      facebookAccount: json['facebook_account'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      idNo: json['id_no'] as String?,
      idType: json['id_type'] as String?,
      idNo1: json['id_no_1'] as String?,
      idType1: json['id_type_1'] as String?,
      jobCategory: json['job_category'] as String?,
      email: json['email'] as String?,
      email1: json['email_1'] as String?,
      educationDegree: json['education_degree'] as String?,
      familyProvince: json['family_province'] as String?,
      familyCity: json['family_city'] as String?,
      familyArea: json['family_area'] as String?,
      familyDetailAddress: json['family_detail_address'] as String?,
      presentProvince: json['present_province'] as String?,
      presentCity: json['present_city'] as String?,
      isInPhilippines: json['is_in_philippines'] as String?,
      loanPurpose: json['loan_purpose'] as String?,
      expectedAmount: json['expected_amount'] as String?,
      presentArea: json['present_area'] as String?,
      idTypeDesc: json['id_type_desc'] as String?,
      presentDetailAddress: json['present_detail_address'] as String?,
      houseStatus: json['house_status'] as String?,
      jobDesc: json['job_desc'] as String?,
      moreIdTypeId: json['more_id_type_id'] as String?,
      idTypeSelected: json['id_type_selected'] as String?,
      idcardFront: json['idcard_front'] as String?,
      idcardHand: json['idcard_hand'] as String?,
      idcardHandSwitch: json['idcard_hand_switch'] as String?,
      employmentJobIdList: json['employment_job_id_list'] as String?,
      idEditable: json['id_editable'] as String?,
      moreIdTypeDesc: json['more_id_type_desc'] as String?,
      employmentStatus: json['employment_status'] as String?,
      companyName: json['company_name'] as String?,
      companyAddress: json['company_address'] as String?,
      companyPhone: json['company_phone'] as String?,
      monthlyIncome: json['monthly_income'] as String?,
      getSalaryDate: json['get_salary_date'] as String?,
      getSalaryDate1: json['get_salary_date_1'] as String?,
      contacter01Name: json['contacter_01_name'] as String?,
      contacter01Relationship: json['contacter_01_relationship'] as String?,
      contacter01Phone: json['contacter_01_phone'] as String?,
      dateOnBoard: json['date_on_board'] as String?,
      latest3MonthsIncome: json['latest_3_months_income'] as String?,
      contacter02Name: json['contacter_02_name'] as String?,
      employeeJobType: json['employee_job_type'] as String?,
      contacter02Relationship: json['contacter_02_relationship'] as String?,
      contacter02Phone: json['contacter_02_phone'] as String?,
      companyProvince: json['company_province'] as String?,
      companyCity: json['company_city'] as String?,
      companyArea: json['company_area'] as String?,
      contactList: (json['contact_list'] as List<dynamic>?)
          ?.map((e) => ContactList.fromJson(e as Map<String, dynamic>))
          .toList(),
      contacterDisplayCount: json['contacter_display_count'] as String?,
      livenessSwitch: json['liveness_switch'] as bool?,
      livenessState: json['liveness_state'] as String?,
      livenessOverLimit: json['liveness_over_limit'] as bool?,
      workLicense: json['work_license'] as String?,
      incomeProof: json['income_proof'] as String?,
      pictureDisplayList: (json['picture_display_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      withdrawInfo: json['withdraw_info'] == null
          ? null
          : WithdrawInfo.fromJson(
              json['withdraw_info'] as Map<String, dynamic>),
      popWindow: json['pop_window'] as bool?,
      withdrawTip: json['withdraw_tip'] as String?,
      withdrawInputTip: (json['withdraw_input_tip'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      channelFee: json['channel_fee'] == null
          ? null
          : ChannelFee.fromJson(json['channel_fee'] as Map<String, dynamic>),
      options: json['options'] == null
          ? null
          : Options.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'current_working_year': instance.currentWorkingYear,
      'marital_status': instance.maritalStatus,
      'quantity_of_children': instance.quantityOfChildren,
      'family_monthly_income': instance.familyMonthlyIncome,
      'present_address_time': instance.presentAddressTime,
      'facebook_account': instance.facebookAccount,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'id_no': instance.idNo,
      'id_type': instance.idType,
      'id_no_1': instance.idNo1,
      'id_type_1': instance.idType1,
      'job_category': instance.jobCategory,
      'email': instance.email,
      'email_1': instance.email1,
      'education_degree': instance.educationDegree,
      'family_province': instance.familyProvince,
      'family_city': instance.familyCity,
      'family_area': instance.familyArea,
      'family_detail_address': instance.familyDetailAddress,
      'present_province': instance.presentProvince,
      'present_city': instance.presentCity,
      'is_in_philippines': instance.isInPhilippines,
      'loan_purpose': instance.loanPurpose,
      'expected_amount': instance.expectedAmount,
      'present_area': instance.presentArea,
      'id_type_desc': instance.idTypeDesc,
      'present_detail_address': instance.presentDetailAddress,
      'house_status': instance.houseStatus,
      'job_desc': instance.jobDesc,
      'more_id_type_id': instance.moreIdTypeId,
      'id_type_selected': instance.idTypeSelected,
      'idcard_front': instance.idcardFront,
      'idcard_hand': instance.idcardHand,
      'idcard_hand_switch': instance.idcardHandSwitch,
      'employment_job_id_list': instance.employmentJobIdList,
      'id_editable': instance.idEditable,
      'more_id_type_desc': instance.moreIdTypeDesc,
      'employment_status': instance.employmentStatus,
      'company_name': instance.companyName,
      'company_address': instance.companyAddress,
      'company_phone': instance.companyPhone,
      'monthly_income': instance.monthlyIncome,
      'get_salary_date': instance.getSalaryDate,
      'get_salary_date_1': instance.getSalaryDate1,
      'contacter_01_name': instance.contacter01Name,
      'contacter_01_relationship': instance.contacter01Relationship,
      'contacter_01_phone': instance.contacter01Phone,
      'date_on_board': instance.dateOnBoard,
      'latest_3_months_income': instance.latest3MonthsIncome,
      'contacter_02_name': instance.contacter02Name,
      'employee_job_type': instance.employeeJobType,
      'contacter_02_relationship': instance.contacter02Relationship,
      'contacter_02_phone': instance.contacter02Phone,
      'company_province': instance.companyProvince,
      'company_city': instance.companyCity,
      'company_area': instance.companyArea,
      'contact_list': instance.contactList,
      'contacter_display_count': instance.contacterDisplayCount,
      'liveness_switch': instance.livenessSwitch,
      'liveness_state': instance.livenessState,
      'liveness_over_limit': instance.livenessOverLimit,
      'work_license': instance.workLicense,
      'income_proof': instance.incomeProof,
      'picture_display_list': instance.pictureDisplayList,
      'withdraw_info': instance.withdrawInfo,
      'pop_window': instance.popWindow,
      'withdraw_tip': instance.withdrawTip,
      'withdraw_input_tip': instance.withdrawInputTip,
      'channel_fee': instance.channelFee,
      'options': instance.options,
    };

ChannelFee _$ChannelFeeFromJson(Map<String, dynamic> json) => ChannelFee(
      displayList: (json['display_list'] as List<dynamic>?)
          ?.map((e) => DisplayList.fromJson(e as Map<String, dynamic>))
          .toList(),
      visible: json['visible '] as bool?,
    );

Map<String, dynamic> _$ChannelFeeToJson(ChannelFee instance) =>
    <String, dynamic>{
      'display_list': instance.displayList,
      'visible ': instance.visible,
    };

DisplayList _$DisplayListFromJson(Map<String, dynamic> json) => DisplayList(
      name: json['name'] as String?,
      displayChannelFee: json['display_channel_fee'] as String?,
      underlinedPrice: json['underlined_price'] as String?,
    );

Map<String, dynamic> _$DisplayListToJson(DisplayList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'display_channel_fee': instance.displayChannelFee,
      'underlined_price': instance.underlinedPrice,
    };

ContactList _$ContactListFromJson(Map<String, dynamic> json) => ContactList(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      relationship: json['relationship'] as String?,
    );

Map<String, dynamic> _$ContactListToJson(ContactList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'relationship': instance.relationship,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      jobCategoryOptions: (json['job_category_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationDegreeOptions:
          (json['education_degree_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      genderOptions: (json['gender_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      idTypeOptions: (json['id_type_options'] as List<dynamic>?)
          ?.map((e) => IdTypeOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      idType1Options: (json['id_type_1_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      maritalStatusOptions: (json['marital_status_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantityOfChildrenOptions:
          (json['quantity_of_children_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      currentWorkingYearOptions:
          (json['current_working_year_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      familyMonthlyIncomeOptions:
          (json['family_monthly_income_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      presentAddressTimeOptions:
          (json['present_address_time_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      houseStatusOptions: (json['house_status_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      loanPurposeOptions: (json['loan_purpose_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      isInPhilippines: (json['is_in_philippines'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      latest3MonthsIncomeOptions:
          (json['latest_3_months_income_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      contacter01Relationship:
          (json['contacter_01_relationship'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      contacter02Relationship:
          (json['contacter_02_relationship'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      employmentStatusOptions:
          (json['employment_status_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      employeeJobTypeOptions:
          (json['employee_job_type_options'] as List<dynamic>?)
              ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      jobCategoryOptions01: (json['job_category_options_01'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobCategoryOptions02: (json['job_category_options_02'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyIncomeOptions: (json['monthly_income_options'] as List<dynamic>?)
          ?.map((e) => CommonListOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      withdrawChannelOptions: (json['withdraw_channel_options']
              as List<dynamic>?)
          ?.map(
              (e) => WithdrawChannelOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'job_category_options': instance.jobCategoryOptions,
      'education_degree_options': instance.educationDegreeOptions,
      'gender_options': instance.genderOptions,
      'id_type_options': instance.idTypeOptions,
      'id_type_1_options': instance.idType1Options,
      'marital_status_options': instance.maritalStatusOptions,
      'quantity_of_children_options': instance.quantityOfChildrenOptions,
      'current_working_year_options': instance.currentWorkingYearOptions,
      'family_monthly_income_options': instance.familyMonthlyIncomeOptions,
      'present_address_time_options': instance.presentAddressTimeOptions,
      'house_status_options': instance.houseStatusOptions,
      'loan_purpose_options': instance.loanPurposeOptions,
      'is_in_philippines': instance.isInPhilippines,
      'latest_3_months_income_options': instance.latest3MonthsIncomeOptions,
      'contacter_01_relationship': instance.contacter01Relationship,
      'contacter_02_relationship': instance.contacter02Relationship,
      'employment_status_options': instance.employmentStatusOptions,
      'employee_job_type_options': instance.employeeJobTypeOptions,
      'job_category_options_01': instance.jobCategoryOptions01,
      'job_category_options_02': instance.jobCategoryOptions02,
      'monthly_income_options': instance.monthlyIncomeOptions,
      'withdraw_channel_options': instance.withdrawChannelOptions,
    };

CommonListOption _$CommonListOptionFromJson(Map<String, dynamic> json) =>
    CommonListOption(
      id: json['id'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$CommonListOptionToJson(CommonListOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

IdTypeOption _$IdTypeOptionFromJson(Map<String, dynamic> json) => IdTypeOption(
      id: json['id'] as String?,
      value: json['value'] as String?,
      recommend: json['recommend'] as String?,
    );

Map<String, dynamic> _$IdTypeOptionToJson(IdTypeOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'recommend': instance.recommend,
    };

WithdrawChannelOption _$WithdrawChannelOptionFromJson(
        Map<String, dynamic> json) =>
    WithdrawChannelOption(
      channelName: json['channel_name'] as String?,
      requireAccountNo: json['require_account_no'] as bool?,
    );

Map<String, dynamic> _$WithdrawChannelOptionToJson(
        WithdrawChannelOption instance) =>
    <String, dynamic>{
      'channel_name': instance.channelName,
      'require_account_no': instance.requireAccountNo,
    };

WithdrawInfo _$WithdrawInfoFromJson(Map<String, dynamic> json) => WithdrawInfo(
      withdrawChannel: json['withdraw_channel'] as String?,
      withdrawAccountNo: json['withdraw_account_no'] as String?,
      withdrawAccountName: json['withdraw_account_name'] as String?,
      email: json['email'] as String?,
      withdrawFirstName: json['withdraw_first_name'] as String?,
      withdrawLastName: json['withdraw_last_name'] as String?,
      withdrawMiddleName: json['withdraw_middle_name'] as String?,
      clientType: json['client_type'] as String?,
    );

Map<String, dynamic> _$WithdrawInfoToJson(WithdrawInfo instance) =>
    <String, dynamic>{
      'withdraw_channel': instance.withdrawChannel,
      'withdraw_account_no': instance.withdrawAccountNo,
      'withdraw_account_name': instance.withdrawAccountName,
      'email': instance.email,
      'withdraw_first_name': instance.withdrawFirstName,
      'withdraw_last_name': instance.withdrawLastName,
      'withdraw_middle_name': instance.withdrawMiddleName,
      'client_type': instance.clientType,
    };
