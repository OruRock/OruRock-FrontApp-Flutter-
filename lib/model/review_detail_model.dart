class ReviewDetailModel {
  List<Question>? question;

  ReviewDetailModel({this.question});

  ReviewDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      question = <Question>[];
      json['list'].forEach((v) {
        question!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (question != null) {
      data['list'] = question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String? questionText;
  int? questionId;

  Question({this.questionText, this.questionId});

  Question.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_text'] = questionText;
    data['question_id'] = questionId;
    return data;
  }
}