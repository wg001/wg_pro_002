import 'package:flutter_test/flutter_test.dart';
import 'package:wg_pro_002/app/model/Home.dart';  // 确保这个路径是正确的
import 'dart:convert';

void main() {
  test('UserLoanInfo parsing test', () {
    var jsonStr = '''
    {
        "reward_box": {
            "tip_01": "Earned <font color=\\"#FFEC00\\">₱3000</font> reward points as clearing debt on time.",
            "tip_02": "",
            "show_reward_box": "0"
        },
        "user_base_info": {
            "slogen": "",
            "phone": "639888888884"
        },
        "user_loan_info": {
            "status": "Waiting for repayment",
            "end_repay_time": "07/04/2024",
            "repay_day_des": "",
            "postponement_discounts": "",
            "interest": "₱ 210",
            "overdue_fee": "",
            "unpaid_amount": "₱ 3210",
            "amount": "₱ 3000",
            "loan_daycount": "91",
            "order_no": "2309111734292104159785",
            "action": "repay",
            "remind_tip": "to avoid overdue fees, please repay on or before the last repayment date.",
            "button_words": "Repay the loan",
            "display_postponement_button": true,
            "installment_repayment_data": {
                "current_repay_date": "07/04/2024",
                "current_amount": "****",
                "current_period": "1",
                "next_repay_date": "07/11/2024",
                "next_amount": "****",
                "next_period": "2"
            },
            "last_repayment_channel": "GCash",
            "order_type": "1",
            "late_fee": "",
            "loan_max_amount_desc": "Max. Credit Amount",
            "loan_max_amount": "25,000",
            "loan_period": "91 days ~ 365 days",
            "loan_apr": "Up to 35%"
        },
        "display_recommend_list": false,
        "need_location": false,
        "picture_page_display": false,
        "feedback_switch": "1",
        "is_new_guest": "1",
        "phone_locked": "0",
        "phone_locked_toast_msg": "",
        "refresh_failed_order": "0",
        "modal_info": {
            "image": "http://51xinjiapo.oss-ap-southeast-1.aliyuncs.com/files1/backend/production/modal/index_modal_001.jpg?OSSAccessKeyId=LTAITZ9Z2fORJ3SC&Expires=1719563947&Signature=a8Cf4tC994SzSh3Jo%2BQEBoaUf4k%3D",
            "link": "https://l.lightkredit.asia/lightkeditNotf"
        },
        "user_lost_contact": "0",
        "history_app": [
            {
                "app_name": "Prima Cash",
                "redirect_url": "https://primacash.xyz",
                "app_logo": "https://51xinjiapo.oss-ap-southeast-1.aliyuncs.com/assets/primacash_logo.png",
                "status": "view"
            }
        ],
        "can_apply": "1",
        "upload_sms": "0",
        "upload_app_list_time_limit": 5,
        "additional_tips": false,
        "privacy_policy": "https://p.pclite.xyz/h5/pages/appPrivacy/index.html?app_name=Prima%20Loan",
        "manup_privacy_policy": "https://p.primaloan.icu/h5/pages/appPrivacy/index.html",
        "manup_service_agreement": "https://p.primaloan.icu/h5/appLoan/userServiveAgreement?appname=Prima Loan",
        "manup_welcome": "",
        "upload_pop": "1",
        "update_google_play": "1",
        "guest_phone": "",
        "guest_phone_v1": [],
        "customer_service": "",
        "fb_account": "",
        "harasse_report_email": "",
        "permission_statement_switch": "1",
        "kratos": false,
        "last_order_info": {
            "id": "65852",
            "order_no": "2309111734292104159785",
            "penalty": "0.00",
            "loan_val": "3000.00",
            "repayable_val": "3210.00",
            "loan_daycount": "91",
            "repay_end_time": "2024-07-04",
            "loan_status": "repay",
            "order_type": "1"
        },
        "kratos_switch": "1",
        "product_characteristics": "aaa"
    }''';
    var jsonData = jsonDecode(jsonStr);
    try {
      var homeData = HomeRet.fromJson(jsonData);
      print('Parsed data successfully: $homeData');
    } catch (e) {
      print('Failed to parse data: $e');
      rethrow;
    }
  });
}
