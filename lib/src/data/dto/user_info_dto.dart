import 'package:base_app/src/domain/entities/user_info_entity.dart';

import 'exchange/base/api_base_data.dart';

class DtoUserInfo implements ApiBaseData {
  DtoUserInfo({
    this.accepted,
    this.activated,
    this.cardsave,
    this.cashout,
    this.confirmed,
    this.countryCode,
    this.currency,
    this.driversId,
    this.email,
    this.emailOn,
    this.groupId,
    this.huawei,
    this.id,
    this.img,
    this.login,
    this.name,
    this.needOferta,
    this.notificationOn,
    this.passwordDatetime,
    this.phone,
    this.position,
    this.referralProgram,
    this.smsConfirm,
    this.soundOn,
    this.soundValue,
    this.taxisId,
    this.taxisPhone,
    this.taxisTelegram,
    this.taxisTitle,
  });

  int? accepted;
  int? activated;
  int? cardsave;
  int? cashout;
  int? confirmed;
  int? countryCode;
  String? currency;
  int? driversId;
  String? email;
  int? emailOn;
  int? groupId;
  int? huawei;
  int? id;
  String? img;
  String? login;
  String? name;
  int? needOferta;
  int? notificationOn;
  String? passwordDatetime;
  String? phone;
  String? position;
  int? referralProgram;
  int? smsConfirm;
  int? soundOn;
  int? soundValue;
  int? taxisId;
  String? taxisPhone;
  String? taxisTelegram;
  String? taxisTitle;

  factory DtoUserInfo.fromJson(Map<String, dynamic> json) => DtoUserInfo(
    accepted: json["accepted"],
    activated: json["activated"],
    cardsave: json["cardsave"],
    cashout: json["cashout"],
    confirmed: json["confirmed"],
    countryCode: json["country_code"],
    currency: json["currency"],
    driversId: json["drivers_id"],
    email: json["email"],
    emailOn: json["email_on"],
    groupId: json["group_id"],
    huawei: json["huawei"],
    id: json["id"],
    img: json["img"],
    login: json["login"],
    name: json["name"],
    needOferta: json["need_oferta"],
    notificationOn: json["notification_on"],
    passwordDatetime: json["password_datetime"],
    phone: json["phone"],
    position: json["position"],
    referralProgram: json["referral_program"],
    smsConfirm: json["sms_confirm"],
    soundOn: json["sound_on"],
    soundValue: json["sound_value"],
    taxisId: json["taxis_id"],
    taxisPhone: json["taxis_phone"],
    taxisTelegram: json["taxis_telegram"],
    taxisTitle: json["taxis_title"],
  );

  EntityUserInfo toEntity() => EntityUserInfo(
    accepted: accepted,
    activated: activated,
    cardsave: cardsave,
    cashout: cashout,
    confirmed: confirmed,
    countryCode: countryCode,
    currency: currency,
    driversId: driversId,
    email: email,
    emailOn: emailOn,
    groupId: groupId,
    huawei: huawei,
    id: id,
    img: img,
    login: login,
    name: name,
    needOferta: needOferta,
    notificationOn: notificationOn,
    passwordDatetime: passwordDatetime,
    phone: phone,
    position: position,
    referralProgram: referralProgram,
    smsConfirm: smsConfirm,
    soundOn: soundOn,
    soundValue: soundValue,
    taxisId: taxisId,
    taxisPhone: taxisPhone,
    taxisTelegram: taxisTelegram,
    taxisTitle: taxisTitle,
  );

}
