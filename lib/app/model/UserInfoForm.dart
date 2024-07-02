
import 'package:json_annotation/json_annotation.dart';

part 'UserInfoForm.g.dart';
@JsonSerializable(includeIfNull: false)
class UserInfoForm {
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

    UserInfoForm({
        this.firstName,
        this.lastName,
        this.middleName,
        this.currentWorkingYear,
        this.maritalStatus,
        this.quantityOfChildren,
        this.familyMonthlyIncome,
        this.presentAddressTime,
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
    });

    factory UserInfoForm.fromJson(Map<String, dynamic> json) => _$UserInfoFormFromJson(json);

    Map<String, dynamic> toJson() => _$UserInfoFormToJson(this);
}
