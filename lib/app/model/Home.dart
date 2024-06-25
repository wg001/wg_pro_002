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
class UserLoanInfo {
  @JsonKey(name: 'remind_tip')
  final String? remindTip;
  final String action;
  @JsonKey(name: 'button_words')
  final String? buttonWords;
  @JsonKey(name: 'loan_max_amount_desc')
  final String? loanMaxAmountDesc;
  @JsonKey(name: 'loan_max_amount', defaultValue: '0')
  final String? loanMaxAmount;
  @JsonKey(name: 'loan_period')
  final String? loanPeriod;
  @JsonKey(name: 'loan_apr')
  final String? loanApr;
  @JsonKey(name: 'callinfo_completed', defaultValue: '0')
  final String? callinfoCompleted;
  @JsonKey(name: 'sms_completed', defaultValue: '0')
  final String? smsCompleted;
  @JsonKey(name: 'phonebook_completed', defaultValue: '0')
  final String? phonebookCompleted;
  @JsonKey(name: 'install_completed', defaultValue: '0')
  final String? installCompleted;
  @JsonKey(name: 'device_info_completed', defaultValue: '0')
  final String? deviceInfoCompleted;

  UserLoanInfo({
    this.remindTip,
    required this.action,
    this.buttonWords,
    this.loanMaxAmountDesc,
    this.loanMaxAmount,
    this.loanPeriod,
    this.loanApr,
    this.callinfoCompleted,
    this.smsCompleted,
    this.phonebookCompleted,
    this.installCompleted,
    this.deviceInfoCompleted,
  });

  factory UserLoanInfo.fromJson(Map<String, dynamic> json) =>
      _$UserLoanInfoFromJson(json);
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

  factory HistoryApp.fromJson(Map<String, dynamic> json) =>
      _$HistoryAppFromJson(json);
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
  @JsonKey(name: 'last_order_info')
  final String? lastOrderInfo;
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
    this.lastOrderInfo,
    this.kratosSwitch,
    this.productCharacteristics,
  });

  factory HomeRet.fromJson(Map<String, dynamic> json) =>
      _$HomeRetFromJson(json);
  Map<String, dynamic> toJson() => _$HomeRetToJson(this);
}
