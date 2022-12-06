import 'dart:ui';

import 'package:flutter/material.dart';

class PopupModel {
  String? endDate;
  String? fileUrl;
  String? subject;
  bool? useYn;
  String? content;
  Color? bgColor;
  int? androidYn;
  int? popupId;
  Color? fontColor;
  int? iosYn;
  String? createDate;
  bool? pushYn;
  String? startDate;

  PopupModel(
      {this.endDate,
        this.fileUrl,
        this.subject,
        this.useYn,
        this.content,
        this.bgColor,
        this.androidYn,
        this.popupId,
        this.fontColor,
        this.iosYn,
        this.createDate,
        this.pushYn,
        this.startDate});

  PopupModel.fromJson(Map<String, dynamic> json) {
    endDate = json['end_date'];
    fileUrl = json['file_url'];
    subject = json['subject'];
    useYn = json['use_yn'];
    content = json['content'];
    bgColor = _getColorByCss(json['bg_color'], defaultColor: Colors.grey);
    androidYn = json['android_yn'];
    popupId = json['popup_id'];
    fontColor = _getColorByCss(json['font_color'], defaultColor: Colors.black);
    iosYn = json['ios_yn'];
    createDate = json['create_date'];
    pushYn = json['push_yn'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['end_date'] = endDate;
    data['file_url'] = fileUrl;
    data['subject'] = subject;
    data['use_yn'] = useYn;
    data['content'] = content;
    data['bg_color'] = bgColor;
    data['android_yn'] = androidYn;
    data['popup_id'] = popupId;
    data['font_color'] = fontColor;
    data['ios_yn'] = iosYn;
    data['create_date'] = createDate;
    data['push_yn'] = pushYn;
    data['start_date'] = startDate;
    return data;
  }

  static Color _getColorByCss(String? css, {required Color defaultColor}) {
    if (css == null) return defaultColor;
    final rgbIndex = css.indexOf('(');
    final sharpIndex = css.indexOf('#');
    if (rgbIndex > -1) {
      var str = css.substring(rgbIndex + 1, css.length - 1);
      str.split(',')[0].trim();
      return Color.fromRGBO(
          int.parse(str.split(',')[0].trim()),
          int.parse(str.split(',')[1].trim()),
          int.parse(str.split(',')[2].trim()),
          1);
    } else if (sharpIndex > -1) {
      var colorHex = css.replaceFirst('#', '0xFF');

      return Color(int.parse(colorHex));
    }

    return defaultColor;
  }
}
