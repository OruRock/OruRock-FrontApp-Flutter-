class NoticeModel {
  bool? useYn;
  String? title;
  String? createDate;
  int? noticeId;

  NoticeModel({this.useYn, this.title, this.createDate, this.noticeId});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    useYn = json['use_yn'];
    title = json['title'];
    createDate = json['create_date'];
    noticeId = json['notice_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['use_yn'] = useYn;
    data['title'] = title;
    data['create_date'] = createDate;
    data['notice_id'] = noticeId;
    return data;
  }
}
