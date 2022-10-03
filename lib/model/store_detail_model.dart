class StoreReviewModel {
  int? storeId;
  String? userNickname;
  String? comment;
  int? recommendLevel;
  int? commentId;
  String? createDate;
  String? updateDate;

  StoreReviewModel(
      {this.storeId,
        this.userNickname,
        this.comment,
        this.recommendLevel,
        this.commentId,
        this.createDate,
        this.updateDate});

  StoreReviewModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    userNickname = json['user_nickname'];
    comment = json['comment'];
    recommendLevel = json['recommend_level'];
    commentId = json['comment_id'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['user_nickname'] = userNickname;
    data['comment'] = comment;
    data['recommend_level'] = recommendLevel;
    data['comment_id'] = commentId;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    return data;
  }
}
