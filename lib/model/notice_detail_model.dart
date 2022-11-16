class NoticeDetailModel {
  String? title;
  String? createDate;
  int? noticeId;
  String? content;

  NoticeDetailModel({this.title, this.createDate, this.noticeId, this.content});

  NoticeDetailModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createDate = json['create_date'];
    noticeId = json['notice_id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['create_date'] = createDate;
    data['notice_id'] = noticeId;
    data['content'] = content;
    return data;
  }
}
