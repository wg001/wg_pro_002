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
      phone: json['phone'] as String?,
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
      userBaseInfo: json['user_base_info'] == null
          ? null
          : UserBaseInfo.fromJson(
              json['user_base_info'] as Map<String, dynamic>),
      userLoanInfo:
          UserLoanInfo.fromJson(json['user_loan_info'] as Map<String, dynamic>),
      displayRecommendList: json['display_recommend_list'] as bool? ?? false,
      needLocation: json['needLocation'] as bool? ?? false,
      picturePageDisplay: json['picturePageDisplay'] as bool? ?? false,
      feedbackSwitch: json['feedback_switch'] as String?,
      isNewGuest: json['is_new_guest'] as String?,
      phoneLocked: json['phone_locked'] as String?,
      phoneLockedToastMsg: json['phone_locked_toast_msg'] as String?,
      refreshFailedOrder: json['refresh_failed_order'] as String?,
      modalInfo: json['modal_info'] == null
          ? null
          : ModalInfo.fromJson(json['modal_info'] as Map<String, dynamic>),
      userLostContact: json['user_lost_contact'] as String?,
      historyApp: (json['historyApp'] as List<dynamic>?)
          ?.map((e) => HistoryApp.fromJson(e as Map<String, dynamic>))
          .toList(),
      canApply: json['can_apply'] as String?,
      uploadSms: json['upload_sms'] as String?,
      additionalTips: json['additionalTips'] as bool? ?? false,
      privacyPolicy: json['privacy_policy'] as String?,
      manupPrivacyPolicy: json['manup_privacy_policy'] as String?,
      manupServiceAgreement: json['manup_service_agreement'] as String?,
      manupWelcome: json['manup_welcome'] as String?,
      uploadPop: json['upload_pop'] as String?,
      updateGooglePlay: json['update_google_play'] as String?,
      guestPhone: json['guest_phone'] as String?,
      guestPhoneV1: (json['guest_phone_v1'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      customerService: json['customer_service'] as String?,
      fbAccount: json['fb_account'] as String?,
      harasseReportEmail: json['harasse_report_email'] as String?,
      permissionStatementSwitch: json['permission_statement_switch'] as String?,
      kratos: json['kratos'] as bool?,
      lastOrderInfo: json['last_order_info'] as String?,
      kratosSwitch: json['kratos_switch'] as String?,
      productCharacteristics: json['product_characteristics'] as String?,
    );

Map<String, dynamic> _$HomeRetToJson(HomeRet instance) => <String, dynamic>{
      'reward_box': instance.rewardBox,
      'user_base_info': instance.userBaseInfo,
      'user_loan_info': instance.userLoanInfo,
      'display_recommend_list': instance.displayRecommendList,
      'needLocation': instance.needLocation,
      'picturePageDisplay': instance.picturePageDisplay,
      'feedback_switch': instance.feedbackSwitch,
      'is_new_guest': instance.isNewGuest,
      'phone_locked': instance.phoneLocked,
      'phone_locked_toast_msg': instance.phoneLockedToastMsg,
      'refresh_failed_order': instance.refreshFailedOrder,
      'modal_info': instance.modalInfo,
      'user_lost_contact': instance.userLostContact,
      'historyApp': instance.historyApp,
      'can_apply': instance.canApply,
      'upload_sms': instance.uploadSms,
      'additionalTips': instance.additionalTips,
      'privacy_policy': instance.privacyPolicy,
      'manup_privacy_policy': instance.manupPrivacyPolicy,
      'manup_service_agreement': instance.manupServiceAgreement,
      'manup_welcome': instance.manupWelcome,
      'upload_pop': instance.uploadPop,
      'update_google_play': instance.updateGooglePlay,
      'guest_phone': instance.guestPhone,
      'guest_phone_v1': instance.guestPhoneV1,
      'customer_service': instance.customerService,
      'fb_account': instance.fbAccount,
      'harasse_report_email': instance.harasseReportEmail,
      'permission_statement_switch': instance.permissionStatementSwitch,
      'kratos': instance.kratos,
      'last_order_info': instance.lastOrderInfo,
      'kratos_switch': instance.kratosSwitch,
      'product_characteristics': instance.productCharacteristics,
    };
