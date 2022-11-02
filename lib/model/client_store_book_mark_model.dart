class ClientStoreBookMarkModel {
  int? bookmarkId;
  int? storeId;
  String? uid;
  String? createDate;

  ClientStoreBookMarkModel(
      {this.bookmarkId,
      this.storeId,
      this.uid,
      this.createDate});

  ClientStoreBookMarkModel.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmark_id'];
    storeId = json['store_id'];
    uid = json['uid'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['bookmark_id'] = bookmarkId;
    data['store_id'] = storeId;
    data['uid'] = uid;
    data['create_date'] = createDate;
    return data;
  }
}