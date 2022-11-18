import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/model/board_comment_model.dart';
import 'package:oru_rock/model/board_model.dart';

import 'board_update.dart';

class BoardController extends GetxController {
  BuildContext? context;
  TextEditingController searchTxtController = TextEditingController();
  FocusNode searchInputBoxNode = FocusNode();
  final auth = Get.find<AuthFunction>();
  final api = Get.find<ApiFunction>();
  var isLoadingProfile = false.obs;

  var selectedBoardCategory = 1.obs;

  Rx<BoardModel?> board = BoardModel().obs;
  var comment = <CommentModel>[].obs;
  var popupMenuItemIndex = 0;
  var search = false.obs;
  ScrollController scrollController = ScrollController();
  ScrollController boardScrollController = ScrollController();
  ScrollController bestBoardScrollController = ScrollController();

  var boardList = <BoardModel>[].obs;
  var bestBoardList = <BoardModel>[].obs;
  var boardPage = 1;
  var bestBoardPage = 1;
  var isBoardEnd = false;
  var isBestBoardEnd = false;
  var enabled = true.obs;
  var boardTitle = "커뮤니티".obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() async {
    await getBoardList();
    await getBestBoardList();
    boardScrollController.addListener(_scrollListener);
    bestBoardScrollController.addListener(_bestScrollListener);
    super.onInit();
  }

  _scrollListener() {
    if (boardScrollController.offset >=
            boardScrollController.position.maxScrollExtent &&
        !boardScrollController.position.outOfRange &&
        !isBoardEnd) {
      ++boardPage;
      getBoardList();
    }
  }

  _bestScrollListener() {
    if (bestBoardScrollController.offset >=
            bestBoardScrollController.position.maxScrollExtent &&
        !bestBoardScrollController.position.outOfRange &&
        !isBestBoardEnd) {
      ++bestBoardPage;
      getBestBoardList();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }


  void showSearchBox() {
    search.value = !search.value;
  }

//게시판 목록 조회
  Future<void> getBoardList() async {
    try {
      final data = {
        "board_category_id": selectedBoardCategory.value,
        "search_txt": searchTxtController.text,
        "uid": auth.user!.uid,
        "curPage": boardPage
      };
      final res = await api.dio.get('/board/list', queryParameters: data);
      BoardResult boardResult = BoardResult.fromJson(res.data["payload"]);
      isBoardEnd = res.data["payload"]["isBoardEnd"];
      if (boardPage == 1) {
        boardList.value = [...boardResult.result.map((e) => e).toList()];
      } else {
        boardList.value = [
          ...boardList.value,
          ...boardResult.result.map((e) => e).toList()
        ];
      }
    } catch (e) {
      print(e);
    }
  }

//게시판 목록 조회
  Future<void> getBestBoardList() async {
    try {
      if (selectedBoardCategory.value == 3) return;
      final data = {
        "board_category_id": selectedBoardCategory.value,
        "search_txt": searchTxtController.text,
        "curPage": bestBoardPage,
        "uid": auth.user!.uid,
        "is_best": 1
      };
      final res = await api.dio.get('/board/list', queryParameters: data);
      BoardResult boardResult = BoardResult.fromJson(res.data["payload"]);
      isBestBoardEnd = res.data["payload"]["isBoardEnd"];
      if (bestBoardPage == 1) {
        bestBoardList.value = [...boardResult.result.map((e) => e).toList()];
      } else {
        bestBoardList.value = [
          ...bestBoardList.value,
          ...boardResult.result.map((e) => e).toList()
        ];
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        enabled.value = false;
      });
    } catch (e) {
      print(e);
    }
  }

//게시판 상세 조회
  Future<void> getBoardDetail(int id, int categoryId) async {
    try {
      enabled.value = true;
      final data = {
        "board_id": id,
        "board_category_id": categoryId,
        "uid": auth.user!.uid
      };
      final res = await api.dio.get('/board/detail', queryParameters: data);
      board.value = BoardModel.fromJson(res.data["payload"]["Board"]);
      comment.value = BoardCommentResult.fromJson(res.data["payload"])
          .result
          .map((e) => e)
          .toList();
      Future.delayed(const Duration(milliseconds: 300), () {
        enabled.value = false;
      });
    } catch (e) {
      print(e);
    }
  }

//게시판 수정
  Future<void> writeBoard(int id, String title, String content) async {
    var data = {
      "board_category_id": selectedBoardCategory.value,
      "subject": title,
      "content": content,
      "uid": auth.user!.uid,
      "nickname": auth.user!.displayName,
      "board_id": id,
      "use_yn": 1,
    };
    final rst = await api.dio.post("/board/write", data: data);
    getBoardDetail(
        rst.data["payload"]["board_id"], selectedBoardCategory.value);

    getBoardList();
  }

//게시판 삭제
  Future<void> deleteBoardById(int id) async {
    var data = {
      "board_category_id": selectedBoardCategory.value,
      "uid": auth.user!.uid,
      "board_id": id
    };
    final rst = await api.dio.post("/board/delete", data: data);
    getBoardList();
  }

  //댓글 삭제
  Future<void> deleteBoardByComment(
    int boardId,
    int commentId,
  ) async {
    var data = {
      "uid": auth.user!.uid,
      "comment_id": commentId,
      "board_id": boardId
    };
    await api.dio.post("/board/comment/delete", data: data);
    getBoardDetail(board.value!.boardId!, selectedBoardCategory.value);
  }

//좋아요 저장
  Future<bool> saveBoardLike(int boardId, bool? islike) async {
    var data = {
      "board_category_id": selectedBoardCategory.value,
      "uid": auth.user!.uid,
      "board_id": boardId
    };
    await api.dio.post("/board/like", data: data);
    //getBoardDetail(board.value!.board_id!, selectedBoardCategory.value);
    return !islike!;
  }

  //좋아요 저장
  Future<bool> saveCommentLike(
      int boardId, int boardCategoryId, int commentId, bool? islike) async {
    var data = {
      "uid": auth.user!.uid,
      "board_id": boardId,
      "comment_id": commentId,
      "board_category_id": boardCategoryId
    };
    await api.dio.post("/board/comment/like", data: data);
    //getBoardDetail(board.value!.board_id!, selectedBoardCategory.value);
    return !islike!;
  }

//댓글 작성
  Future<void> writeComment(int id, String comment) async {
    var data = {
      "board_category_id": board.value?.boardCategoryId,
      "board_id": board.value?.boardId,
      "comment_id": id,
      "uid": auth.user!.uid,
      "comment": comment,
      "nickname": auth.user!.displayName,
    };

    if (comment.isEmpty) {
      Fluttertoast.showToast(msg: '댓글엔 공백이 들어갈 수 없습니다.');
    } else if (comment.length > 28) {
      Fluttertoast.showToast(msg: '28자이내로 작성해주세요.');
    } else {
      final rst = await api.dio.post("/board/comment", data: data);

      Fluttertoast.showToast(msg: '댓글이 작성되었습니다.');
      FocusScope.of(Get.context!).unfocus();
      getBoardDetail(board.value!.boardId!, selectedBoardCategory.value);
      scrollToBottom();
    }
  }

  scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

//드로워 아이콘
  final iconArr = {
    "1": const Icon(EvaIcons.radioOutline),
    "2": const Icon(Icons.backup_table_outlined),
    "3": const Icon(Icons.account_balance_outlined),
    "4": const Icon(Icons.laptop_chromebook_rounded),
  };

  PopupMenuItem buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Malgun Gothic',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> commentErase(int boardId, int commentId) async {
    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '댓글을 삭제하시겠습니까?',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await deleteBoardByComment(boardId, commentId);
                Get.back();
              },
              child: const Text('네'),
            ),
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('아니오'),
            ),
          ],
        );
      },
    );
  }

  onMenuItemSelected(int value, BuildContext context) {
    popupMenuItemIndex = value;

    if (value == Options.edit.index) {
      if (auth.user!.uid == board.value?.uid) {
        Get.to(() => BoardUpdatePage());
      }
    } else if (value == Options.delete.index) {
      if (auth.user!.uid == board.value?.uid) {
        Get.back();
        Fluttertoast.showToast(msg: '삭제완료우.');
        deleteBoardById(board.value?.boardId as int); // 상태관리로 갱신 시킬 수 있음.
      }
    }
  }
}

enum Options { edit, delete }
