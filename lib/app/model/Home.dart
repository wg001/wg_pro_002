import 'package:json_annotation/json_annotation.dart';

part 'Home.g.dart';

@JsonSerializable()
class RewardBox {
  @JsonKey(name: 'tip_01')
  final String? tip01;
  @JsonKey(name: 'tip_02')
  final String? tip02;
  @JsonKey(name: 'show_reward_box', defaultValue: '0')
  final String? showRewardBox;

  RewardBox({
    this.tip01,
    this.tip02,
    this.showRewardBox,
  });

  factory RewardBox.fromJson(Map<String, dynamic> json) =>
      _$RewardBoxFromJson(json);
  Map<String, dynamic> toJson() => _$RewardBoxToJson(this);
}

@JsonSerializable()
class UserBaseInfo {
  final String? slogen;
  final String? phone;

  UserBaseInfo({this.slogen, this.phone});

  factory UserBaseInfo.fromJson(Map<String, dynamic> json) =>
      _$UserBaseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserBaseInfoToJson(this);
}

@JsonSerializable()
class InstallmentRepaymentData {
  @JsonKey(name: 'current_repay_date')
  final String? currentRepayDate;
  @JsonKey(name: 'current_amount')
  final String? currentAmount;
  @JsonKey(name: 'current_period')
  final String? currentPeriod;
  @JsonKey(name: 'next_repay_date')
  final String? nextRepayDate;
  @JsonKey(name: 'next_amount')
  final String? nextAmount;
  @JsonKey(name: 'next_period')
  final String? nextPeriod;

  InstallmentRepaymentData({
    this.currentRepayDate,
    this.currentAmount,
    this.currentPeriod,
    this.nextRepayDate,
    this.nextAmount,
    this.nextPeriod,
  });

  factory InstallmentRepaymentData.fromJson(Map<String, dynamic> json) =>
      _$InstallmentRepaymentDataFromJson(json);

  Map<String, dynamic> toJson() => _$InstallmentRepaymentDataToJson(this);
}

@JsonSerializable()
class UserLoanInfo {
  @JsonKey(name: 'remind_tip')
  final String? remindTip;
  final String? action;
  @JsonKey(name: 'button_words')
  final String? buttonWords;
  @JsonKey(name: 'loan_max_amount_desc')
  final String? loanMaxAmountDesc;
  @JsonKey(name: 'loan_max_amount', defaultValue: '')
  final String? loanMaxAmount;
  @JsonKey(name: 'loan_period')
  final String? loanPeriod;
  @JsonKey(name: 'loan_apr')
  final String? loanApr;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'callinfo_completed', defaultValue: '')
  final String? callinfoCompleted;
  @JsonKey(name: 'sms_completed', defaultValue: '')
  final String? smsCompleted;
  @JsonKey(name: 'phonebook_completed', defaultValue: '')
  final String? phonebookCompleted;
  @JsonKey(name: 'install_completed', defaultValue: '')
  final String? installCompleted;
  @JsonKey(name: 'device_info_completed', defaultValue: '')
  final String? deviceInfoCompleted;

  @JsonKey(name: 'end_repay_time')
  final String? endRepayTime;
  @JsonKey(name: 'repay_day_des')
  final String? repayDayDes;
  @JsonKey(name: 'postponement_discounts')
  final String? postponementDiscounts;

  final String? interest;
  @JsonKey(name: 'overdue_fee')
  final String? overdueFee;
  @JsonKey(name: 'upaid_amount')
  final String? unpaidAmount;
  @JsonKey(name: 'amount')
  final String? amount;
  @JsonKey(name: 'loan_daycount')
  final String? loanDaycount;
  @JsonKey(name: 'order_no')
  final String? orderNo;

  @JsonKey(name: 'display_postponement_button')
  final bool? displayPostponementButton;

  @JsonKey(name: 'installment_repayment_data')
  final InstallmentRepaymentData? installmentRepaymentData;

  @JsonKey(name: 'last_repayment_channel')
  final String? lastRepaymentChannel;

  @JsonKey(name: 'order_type')
  final String? orderType;

  @JsonKey(name: 'late_fee')
  final String? lateFee;

  UserLoanInfo({
    this.interest,
    this.overdueFee,
    this.unpaidAmount,
    this.amount,
    this.loanDaycount,
    this.orderNo,
    this.displayPostponementButton,
    this.installmentRepaymentData,
    this.lastRepaymentChannel,
    this.orderType,
    this.lateFee,
    this.remindTip,
    this.action,
    this.buttonWords,
    this.loanMaxAmountDesc,
    this.loanMaxAmount,
    this.loanPeriod,
    this.loanApr,
    this.status,
    this.callinfoCompleted,
    this.smsCompleted,
    this.phonebookCompleted,
    this.installCompleted,
    this.deviceInfoCompleted,
    this.endRepayTime,
    this.repayDayDes,
    this.postponementDiscounts,
  });

  // factory UserLoanInfo.fromJson(Map<String, dynamic> json) =>
  //     _$UserLoanInfoFromJson(json);
  factory UserLoanInfo.fromJson(Map<String, dynamic> json) {
    print("Parsing UserLoanInfo: $json");
    return _$UserLoanInfoFromJson(json);
  }
  Map<String, dynamic> toJson() => _$UserLoanInfoToJson(this);
}

@JsonSerializable()
class ModalInfo {
  final String? image;
  final String? link;

  ModalInfo({this.image, this.link});

  factory ModalInfo.fromJson(Map<String, dynamic> json) =>
      _$ModalInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ModalInfoToJson(this);
}

@JsonSerializable()
class HistoryApp {
  @JsonKey(name: 'app_name')
  final String? appName;
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;
  @JsonKey(name: 'app_logo')
  final String? appLogo;
  final String? status;

  HistoryApp({
    this.appName,
    this.redirectUrl,
    this.appLogo,
    this.status,
  });

  factory HistoryApp.fromJson(Map<String, dynamic> json) {
    print("Parsing HistoryApp: $json");
    return _$HistoryAppFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HistoryAppToJson(this);
}

@JsonSerializable()
class HomeRet {
  @JsonKey(name: 'reward_box')
  final RewardBox? rewardBox;
  @JsonKey(name: 'user_base_info')
  final UserBaseInfo? userBaseInfo;
  @JsonKey(name: 'user_loan_info')
  final UserLoanInfo userLoanInfo;
  @JsonKey(name: 'display_recommend_list')
  final bool? displayRecommendList;
  final bool? needLocation;
  final bool? picturePageDisplay;
  @JsonKey(name: 'feedback_switch')
  final String? feedbackSwitch;
  @JsonKey(name: 'is_new_guest')
  final String? isNewGuest;
  @JsonKey(name: 'phone_locked')
  final String? phoneLocked;
  @JsonKey(name: 'phone_locked_toast_msg')
  final String? phoneLockedToastMsg;
  @JsonKey(name: 'refresh_failed_order')
  final String? refreshFailedOrder;
  @JsonKey(name: 'modal_info')
  final ModalInfo? modalInfo;
  @JsonKey(name: 'user_lost_contact')
  final String? userLostContact;
  final List<HistoryApp>? historyApp;
  @JsonKey(name: 'can_apply')
  final String? canApply;
  @JsonKey(name: 'upload_sms')
  final String? uploadSms;
  final bool? additionalTips;
  @JsonKey(name: 'privacy_policy')
  final String? privacyPolicy;
  @JsonKey(name: 'manup_privacy_policy')
  final String? manupPrivacyPolicy;
  @JsonKey(name: 'manup_service_agreement')
  final String? manupServiceAgreement;
  @JsonKey(name: 'manup_welcome')
  final String? manupWelcome;
  @JsonKey(name: 'upload_pop')
  final String? uploadPop;
  @JsonKey(name: 'update_google_play')
  final String? updateGooglePlay;
  @JsonKey(name: 'guest_phone')
  final String? guestPhone;
  @JsonKey(name: 'guest_phone_v1')
  final List<String>? guestPhoneV1;
  @JsonKey(name: 'customer_service')
  final String? customerService;
  @JsonKey(name: 'fb_account')
  final String? fbAccount;
  @JsonKey(name: 'harasse_report_email')
  final String? harasseReportEmail;
  @JsonKey(name: 'permission_statement_switch')
  final String? permissionStatementSwitch;
  final bool? kratos;
  @JsonKey(name: 'kratos_switch')
  final String? kratosSwitch;
  @JsonKey(name: 'product_characteristics')
  final String? productCharacteristics;

  HomeRet({
    this.rewardBox,
    required this.userBaseInfo,
    required this.userLoanInfo,
    this.displayRecommendList = false,
    this.needLocation = false,
    this.picturePageDisplay = false,
    this.feedbackSwitch,
    this.isNewGuest,
    this.phoneLocked,
    this.phoneLockedToastMsg,
    this.refreshFailedOrder,
    this.modalInfo,
    this.userLostContact,
    this.historyApp,
    this.canApply,
    this.uploadSms,
    this.additionalTips = false,
    this.privacyPolicy,
    this.manupPrivacyPolicy,
    this.manupServiceAgreement,
    this.manupWelcome,
    this.uploadPop,
    this.updateGooglePlay,
    this.guestPhone,
    this.guestPhoneV1,
    this.customerService,
    this.fbAccount,
    this.harasseReportEmail,
    this.permissionStatementSwitch,
    this.kratos,
    this.kratosSwitch,
    this.productCharacteristics,
  });

  factory HomeRet.fromJson(Map<String, dynamic> json) =>
      _$HomeRetFromJson(json);
  Map<String, dynamic> toJson() => _$HomeRetToJson(this);
}
