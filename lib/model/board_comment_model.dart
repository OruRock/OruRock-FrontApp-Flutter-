import 'package:jiffy/jiffy.dart';

class BoardCommentResult {
  final List<CommentModel> result;
  BoardCommentResult({required this.result});
  factory BoardCommentResult.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Comment'] as List;
    List<CommentModel> commentList = list.map((i) => CommentModel.fromJson(i)).toList();
    return BoardCommentResult(
      result: commentList,
    );
  }
}

class CommentModel {
  final int? commentId;
  final int? boardId;
  final int? parentComment;
  final String? comment;
  final String? createDate;
  final String? updateDate;
  final String? uid;
  final String? nickName;
  final int? commentLikeCnt;
  final int? isLike;
  final bool? useYn;

  CommentModel({
    this.commentId,
    this.boardId,
    this.parentComment,
    this.comment,
    this.createDate,
    this.updateDate,
    this.uid,
    this.nickName,
    this.commentLikeCnt,
    this.isLike,
    this.useYn,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['comment_id'] ?? 0,
      boardId: json['board_id']?? 0,
      parentComment: json['parent_comment']?? 0,
      comment: json['comment']?? '',
      createDate: Jiffy( json['create_date'] ).from( DateTime.now().add(Duration(hours: 9)) ),
      updateDate: Jiffy( json['update_date'] ).from( DateTime.now().add(Duration(hours: 9)) ),
      uid: json['uid']?? '',
      nickName: json['user_nickname']?? '',
      commentLikeCnt: json['comment_like_cnt']?? 0,
      isLike: json['is_like']?? 0,
      useYn: json['use_yn']?? false,
    );
  }
}
