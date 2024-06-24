// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardBox _$RewardBoxFromJson(Map<String, dynamic> json) => RewardBox(
      tip01: json['tip_01'] as String?,
      tip02: json['tip_02'] as String?,
      showRewardBox: json['show_reward_box'] as String? ?? '0',
    );

Map<String, dynamic> _$RewardBoxToJson(RewardBox instance) => <String, dynamic>{
      'tip_01': instance.tip01,
      'tip_02': instance.tip02,
      'show_reward_box': instance.showRewardBox,
    };

UserBaseInfo _$UserBaseInfoFromJson(Map<String, dynamic> json) => UserBaseInfo(
      slogen: json['slogen'] as String?,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserBaseInfoToJson(UserBaseInfo instance) =>
    <String, dynamic>{
      'slogen': instance.slogen,
      'phone': instance.phone,
    };

UserLoanInfo _$UserLoanInfoFromJson(Map<String, dynamic> json) => UserLoanInfo(
      remindTip: json['remind_tip'] as String?,
      action: json['action'] as String,
      buttonWords: json['button_words'] as String?,
      loanMaxAmountDesc: json['loan_max_amount_desc'] as String?,
      loanMaxAmount: json['loan_max_amount'] as String? ?? '0',
      loanPeriod: json['loan_period'] as String?,
      loanApr: json['loan_apr'] as String?,
      callinfoCompleted: json['callinfo_completed'] as String? ?? '0',
      smsCompleted: json['sms_completed'] as String? ?? '0',
      phonebookCompleted: json['phonebook_completed'] as String? ?? '0',
      installCompleted: json['install_completed'] as String? ?? '0',
      deviceInfoCompleted: json['device_info_completed'] as String? ?? '0',
    );

Map<String, dynamic> _$UserLoanInfoToJson(UserLoanInfo instance) =>
    <String, dynamic>{
      'remind_tip': instance.remindTip,
      'action': instance.action,
      'button_words': instance.buttonWords,
      'loan_max_amount_desc': instance.loanMaxAmountDesc,
      'loan_max_amount': instance.loanMaxAmount,
      'loan_period': instance.loanPeriod,
      'loan_apr': instance.loanApr,
      'callinfo_completed': instance.callinfoCompleted,
      'sms_completed': instance.smsCompleted,
      'phonebook_completed': instance.phonebookCompleted,
      'install_completed': instance.installCompleted,
      'device_info_completed': instance.deviceInfoCompleted,
    };

ModalInfo _$ModalInfoFromJson(Map<String, dynamic> json) => ModalInfo(
      image: json['image'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ModalInfoToJson(ModalInfo instance) => <String, dynamic>{
      'image': instance.image,
      'link': instance.link,
    };

HistoryApp _$HistoryAppFromJson(Map<String, dynamic> json) => HistoryApp(
      appName: json['app_name'] as String?,
      redirectUrl: json['redirect_url'] as String?,
      appLogo: json['app_logo'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$HistoryAppToJson(HistoryApp instance) =>
    <String, dynamic>{
      'app_name': instance.appName,
      'redirect_url': instance.redirectUrl,
      'app_logo': instance.appLogo,
      'status': instance.status,
    };

HomeRet _$HomeRetFromJson(Map<String, dynamic> json) => HomeRet(
      rewardBox: json['reward_box'] == null
          ? null
          : RewardBox.fromJson(json['reward_box'] as Map<String, dynamic>),
      userBaseInfo:
          UserBaseInfo.fromJson(json['user_base_info'] as Map<String, dynamic>),
      userLoanInfo:
          UserLoanInfo.fromJson(json['user_loan_info'] as Map<String, dynamic>),
      displayRecommendList: json['displayRecommendList'] as bool? ?? false,
      needLocation: json['needLocation'] as bool? ?? false,
      picturePageDisplay: json['picturePageDisplay'] as bool? ?? false,
      feedbackSwitch: json['feedbackSwitch'] as String,
      isNewGuest: json['isNewGuest'] as String,
      phoneLocked: json['phoneLocked'] as String,
      phoneLockedToastMsg: json['phoneLockedToastMsg'] as String,
      refreshFailedOrder: json['refreshFailedOrder'] as String,
      modalInfo: json['modalInfo'] == null
          ? null
          : ModalInfo.fromJson(json['modalInfo'] as Map<String, dynamic>),
      userLostContact: json['userLostContact'] as String,
      historyApp: (json['historyApp'] as List<dynamic>?)
          ?.map((e) => HistoryApp.fromJson(e as Map<String, dynamic>))
          .toList(),
      canApply: json['canApply'] as String,
      uploadSms: json['uploadSms'] as String,
      additionalTips: json['additionalTips'] as bool? ?? false,
      privacyPolicy: json['privacyPolicy'] as String,
      manupPrivacyPolicy: json['manupPrivacyPolicy'] as String,
      manupServiceAgreement: json['manupServiceAgreement'] as String,
      manupWelcome: json['manupWelcome'] as String,
      uploadPop: json['uploadPop'] as String,
      updateGooglePlay: json['updateGooglePlay'] as String,
      guestPhone: json['guestPhone'] as String,
      guestPhoneV1: (json['guestPhoneV1'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      customerService: json['customerService'] as String,
      fbAccount: json['fbAccount'] as String,
      harasseReportEmail: json['harasseReportEmail'] as String,
      permissionStatementSwitch: json['permissionStatementSwitch'] as String,
      kratos: json['kratos'] as bool,
      lastOrderInfo: json['lastOrderInfo'] as String?,
      kratosSwitch: json['kratosSwitch'] as String,
      productCharacteristics: json['productCharacteristics'] as String,
    );

Map<String, dynamic> _$HomeRetToJson(HomeRet instance) => <String, dynamic>{
      'reward_box': instance.rewardBox,
      'user_base_info': instance.userBaseInfo,
      'user_loan_info': instance.userLoanInfo,
      'displayRecommendList': instance.displayRecommendList,
      'needLocation': instance.needLocation,
      'picturePageDisplay': instance.picturePageDisplay,
      'feedbackSwitch': instance.feedbackSwitch,
      'isNewGuest': instance.isNewGuest,
      'phoneLocked': instance.phoneLocked,
      'phoneLockedToastMsg': instance.phoneLockedToastMsg,
      'refreshFailedOrder': instance.refreshFailedOrder,
      'modalInfo': instance.modalInfo,
      'userLostContact': instance.userLostContact,
      'historyApp': instance.historyApp,
      'canApply': instance.canApply,
      'uploadSms': instance.uploadSms,
      'additionalTips': instance.additionalTips,
      'privacyPolicy': instance.privacyPolicy,
      'manupPrivacyPolicy': instance.manupPrivacyPolicy,
      'manupServiceAgreement': instance.manupServiceAgreement,
      'manupWelcome': instance.manupWelcome,
      'uploadPop': instance.uploadPop,
      'updateGooglePlay': instance.updateGooglePlay,
      'guestPhone': instance.guestPhone,
      'guestPhoneV1': instance.guestPhoneV1,
      'customerService': instance.customerService,
      'fbAccount': instance.fbAccount,
      'harasseReportEmail': instance.harasseReportEmail,
      'permissionStatementSwitch': instance.permissionStatementSwitch,
      'kratos': instance.kratos,
      'lastOrderInfo': instance.lastOrderInfo,
      'kratosSwitch': instance.kratosSwitch,
      'productCharacteristics': instance.productCharacteristics,
    };
