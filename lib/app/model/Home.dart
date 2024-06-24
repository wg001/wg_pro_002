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

  factory RewardBox.fromJson(Map<String, dynamic> json) => _$RewardBoxFromJson(json);
  Map<String, dynamic> toJson() => _$RewardBoxToJson(this);
}

@JsonSerializable()
class UserBaseInfo {
  final String? slogen;
  final String phone;

  UserBaseInfo({this.slogen, required this.phone});

  factory UserBaseInfo.fromJson(Map<String, dynamic> json) => _$UserBaseInfoFromJson(json);
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

  factory UserLoanInfo.fromJson(Map<String, dynamic> json) => _$UserLoanInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoanInfoToJson(this);
}

@JsonSerializable()
class ModalInfo {
  final String? image;
  final String? link;

  ModalInfo({this.image, this.link});

  factory ModalInfo.fromJson(Map<String, dynamic> json) => _$ModalInfoFromJson(json);
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

  factory HistoryApp.fromJson(Map<String, dynamic> json) => _$HistoryAppFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryAppToJson(this);
}

@JsonSerializable()
class HomeRet {
  @JsonKey(name: 'reward_box')
  final RewardBox? rewardBox;
  @JsonKey(name: 'user_base_info')
  final UserBaseInfo userBaseInfo;
  @JsonKey(name: 'user_loan_info')
  final UserLoanInfo userLoanInfo;
  final bool displayRecommendList;
  final bool needLocation;
  final bool picturePageDisplay;
  final String feedbackSwitch;
  final String isNewGuest;
  final String phoneLocked;
  final String phoneLockedToastMsg;
  final String refreshFailedOrder;
  final ModalInfo? modalInfo;
  final String userLostContact;
  final List<HistoryApp>? historyApp;
  final String canApply;
  final String uploadSms;
  final bool additionalTips;
  final String privacyPolicy;
  final String manupPrivacyPolicy;
  final String manupServiceAgreement;
  final String manupWelcome;
  final String uploadPop;
  final String updateGooglePlay;
  final String guestPhone;
  final List<String>? guestPhoneV1;
  final String customerService;
  final String fbAccount;
  final String harasseReportEmail;
  final String permissionStatementSwitch;
  final bool kratos;
  final String? lastOrderInfo;
  final String kratosSwitch;
  final String productCharacteristics;

  HomeRet({
    this.rewardBox,
    required this.userBaseInfo,
    required this.userLoanInfo,
    this.displayRecommendList = false,
    this.needLocation = false,
    this.picturePageDisplay = false,
    required this.feedbackSwitch,
    required this.isNewGuest,
    required this.phoneLocked,
    required this.phoneLockedToastMsg,
    required this.refreshFailedOrder,
    this.modalInfo,
    required this.userLostContact,
    this.historyApp,
    required this.canApply,
    required this.uploadSms,
    this.additionalTips = false,
    required this.privacyPolicy,
    required this.manupPrivacyPolicy,
    required this.manupServiceAgreement,
    required this.manupWelcome,
    required this.uploadPop,
    required this.updateGooglePlay,
    required this.guestPhone,
    this.guestPhoneV1,
    required this.customerService,
    required this.fbAccount,
    required this.harasseReportEmail,
    required this.permissionStatementSwitch,
    required this.kratos,
    this.lastOrderInfo,
    required this.kratosSwitch,
    required this.productCharacteristics,
  });

 factory HomeRet.fromJson(Map<String, dynamic> json) => _$HomeRetFromJson(json);
  Map<String, dynamic> toJson() => _$HomeRetToJson(this);
}

