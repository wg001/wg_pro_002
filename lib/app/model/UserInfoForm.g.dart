// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfoForm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoForm _$UserInfoFormFromJson(Map<String, dynamic> json) => UserInfoForm(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      middleName: json['middle_name'] as String?,
      currentWorkingYear: json['current_working_year'] as String?,
      maritalStatus: json['marital_status'] as String?,
      quantityOfChildren: json['quantity_of_children'] as String?,
      familyMonthlyIncome: json['family_monthly_income'] as String?,
      presentAddressTime: json['present_address_time'] as String?,
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
    );

Map<String, dynamic> _$UserInfoFormToJson(UserInfoForm instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('middle_name', instance.middleName);
  writeNotNull('current_working_year', instance.currentWorkingYear);
  writeNotNull('marital_status', instance.maritalStatus);
  writeNotNull('quantity_of_children', instance.quantityOfChildren);
  writeNotNull('family_monthly_income', instance.familyMonthlyIncome);
  writeNotNull('present_address_time', instance.presentAddressTime);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('gender', instance.gender);
  writeNotNull('id_no', instance.idNo);
  writeNotNull('id_type', instance.idType);
  writeNotNull('id_no_1', instance.idNo1);
  writeNotNull('id_type_1', instance.idType1);
  writeNotNull('job_category', instance.jobCategory);
  writeNotNull('email', instance.email);
  writeNotNull('email_1', instance.email1);
  writeNotNull('education_degree', instance.educationDegree);
  writeNotNull('family_province', instance.familyProvince);
  writeNotNull('family_city', instance.familyCity);
  writeNotNull('family_area', instance.familyArea);
  writeNotNull('family_detail_address', instance.familyDetailAddress);
  writeNotNull('present_province', instance.presentProvince);
  writeNotNull('present_city', instance.presentCity);
  writeNotNull('is_in_philippines', instance.isInPhilippines);
  writeNotNull('loan_purpose', instance.loanPurpose);
  writeNotNull('expected_amount', instance.expectedAmount);
  writeNotNull('present_area', instance.presentArea);
  writeNotNull('id_type_desc', instance.idTypeDesc);
  writeNotNull('present_detail_address', instance.presentDetailAddress);
  writeNotNull('house_status', instance.houseStatus);
  writeNotNull('job_desc', instance.jobDesc);
  writeNotNull('more_id_type_id', instance.moreIdTypeId);
  writeNotNull('id_type_selected', instance.idTypeSelected);
  writeNotNull('idcard_front', instance.idcardFront);
  writeNotNull('idcard_hand', instance.idcardHand);
  writeNotNull('idcard_hand_switch', instance.idcardHandSwitch);
  writeNotNull('employment_job_id_list', instance.employmentJobIdList);
  writeNotNull('id_editable', instance.idEditable);
  writeNotNull('more_id_type_desc', instance.moreIdTypeDesc);
  writeNotNull('employment_status', instance.employmentStatus);
  writeNotNull('company_name', instance.companyName);
  writeNotNull('company_address', instance.companyAddress);
  writeNotNull('company_phone', instance.companyPhone);
  writeNotNull('monthly_income', instance.monthlyIncome);
  writeNotNull('get_salary_date', instance.getSalaryDate);
  writeNotNull('get_salary_date_1', instance.getSalaryDate1);
  writeNotNull('contacter_01_name', instance.contacter01Name);
  writeNotNull('contacter_01_relationship', instance.contacter01Relationship);
  writeNotNull('contacter_01_phone', instance.contacter01Phone);
  writeNotNull('date_on_board', instance.dateOnBoard);
  writeNotNull('latest_3_months_income', instance.latest3MonthsIncome);
  writeNotNull('contacter_02_name', instance.contacter02Name);
  writeNotNull('employee_job_type', instance.employeeJobType);
  writeNotNull('contacter_02_relationship', instance.contacter02Relationship);
  writeNotNull('contacter_02_phone', instance.contacter02Phone);
  writeNotNull('company_province', instance.companyProvince);
  writeNotNull('company_city', instance.companyCity);
  writeNotNull('company_area', instance.companyArea);
  return val;
}
