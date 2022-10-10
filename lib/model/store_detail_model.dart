class StoreReviewModel {
  List<Image>? image;
  int? total;
  List<Comment>? comment;

  StoreReviewModel({this.image, this.total, this.comment});

  StoreReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
    total = json['total'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    if (comment != null) {
      data['comment'] = comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? imageUrl;
  int? imageId;

  Image({this.imageUrl, this.imageId});

  Image.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['image_id'] = imageId;
    return data;
  }
}

class Comment {
  int? storeId;
  String? comment;
  int? recommendLevel;
  int? commentId;
  String? createDate;
  String? updateDate;

  Comment(
      {this.storeId,
        this.comment,
        this.recommendLevel,
        this.commentId,
        this.createDate,
        this.updateDate});

  Comment.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    comment = json['comment'];
    recommendLevel = json['recommend_level'];
    commentId = json['comment_id'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['comment'] = comment;
    data['recommend_level'] = recommendLevel;
    data['comment_id'] = commentId;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    return data;
  }
}
