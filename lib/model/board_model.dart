import 'package:jiffy/jiffy.dart';

class BoardResult {
  final List<BoardModel> result;

  BoardResult({required this.result});

  factory BoardResult.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['list'] as List;
    List<BoardModel> BoardList =
        list.map((i) => BoardModel.fromJson(i)).toList();
    return BoardResult(
      result: BoardList,
    );
  }
}

class BoardModel {
  final int? boardId;
  final int? boardCategoryId;
  final String? subject;
  final String? content;
  final int? noticeYn;
  final String? createDate;
  final String? oriCreateDate;
  final String? updateDate;
  final String? oriUpdateDate;
  final String? author;
  final String? uid;
  final String? profileUrl;
  int? recommendCnt = 0;
  final int? views;
  final int? commentCnt;
  int? isLike = 0;

  BoardModel({
    this.boardId,
    this.boardCategoryId,
    this.subject,
    this.content,
    this.author,
    this.uid,
    this.noticeYn,
    this.createDate,
    this.oriCreateDate,
    this.updateDate,
    this.oriUpdateDate,
    this.recommendCnt,
    this.views,
    this.commentCnt,
    this.isLike,
    this.profileUrl,
  });

  void recommned_cnt(int cnt) {
    recommendCnt = cnt;
  }

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      boardId: json['board_id'] ?? 0,
      boardCategoryId: json['board_category_id'] ?? 0,
      subject: json['subject'] ?? '',
      content: json['content'] ?? '',
      noticeYn: json['notice_yn'] ?? 0,
      createDate: Jiffy(json['create_date'])
          .from(DateTime.now().add(const Duration(hours: 9))),
      oriCreateDate: json['create_date'],
      updateDate: Jiffy(json['update_date'])
          .from(DateTime.now().add(const Duration(hours: 9))),
      oriUpdateDate: json['update_date'],
      author: json['user_nickname'],
      uid: json['uid'],
      recommendCnt: json['recommend_cnt'],
      views: json['views'],
      commentCnt: json['comment_cnt'],
      isLike: json['is_like'],
      profileUrl: json['profile_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['board_id'] = boardId;
    map['board_category_id'] = boardCategoryId;
    map['subject'] = subject;
    map['content'] = content;
    map['notice_yn'] = noticeYn;
    map['create_date'] = oriCreateDate;
    map['update_date'] = oriUpdateDate;
    map['user_nickname'] = author;
    map['uid'] = uid;
    map['recommend_cnt'] = recommendCnt;
    map['views'] = views;
    map['comment_cnt'] = commentCnt;
    map['is_like'] = isLike;
    map['profile_url'] = profileUrl;
    return map;
  }
}
