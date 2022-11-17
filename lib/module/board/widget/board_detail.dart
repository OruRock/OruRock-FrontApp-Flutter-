import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:oru_rock/common_widget/banner_ad.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/board/board_controller.dart';
import '../../app/app.dart';

class BoardDetail extends GetView<BoardController> {
  @override
  Widget build(BuildContext context) {
    final comment = TextEditingController();
    BoardController boardController = Get.put(BoardController());
    final FirebaseAuth fire = FirebaseAuth.instance;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('커뮤니티',),
          actions: [
            Visibility(
              visible: fire.currentUser!.uid ==
                  boardController.board.value?.uid,
              child: PopupMenuButton(
                onSelected: (value) {
                  controller.onMenuItemSelected(value as int, context);
                },
                itemBuilder: (ctx) => [
                  controller.buildPopupMenuItem(
                      '편집', Icons.edit, Options.edit.index),
                  controller.buildPopupMenuItem(
                      '삭제', Icons.delete, Options.delete.index),
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            boardController.board.value?.subject ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: GapSize.xxSmall,
                                ),
                                Text(
                                  controller.board.value?.author ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '${controller.board.value?.createDate}' ??
                                      '',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: GapSize.xxxSmall,
                                ),
                                Text(
                                  '${controller.board.value?.views ?? 0}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    const Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: GapSize.medium),
                      child: Text(controller.board.value?.content ?? ''),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LikeButton(
                          size: 30,
                          circleColor: const CircleColor(
                              start: Color(0xfff0ddff), end: Color(0xffffb5e5)),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color(0xffffb5e5),
                            dotSecondaryColor: Color(0xffff99cc),
                          ),
                          isLiked: controller.board.value?.isLike == 1,
                          onTap: (bool isLiked) {
                            return controller.saveBoardLike(
                                controller.board.value?.boardId as int,
                                isLiked);
                          },
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isLiked ? EvaIcons.heart : EvaIcons.heartOutline,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 30,
                            );
                          },
                          likeCount: controller.board.value?.recommendCnt,
                          countBuilder:
                              (int? count, bool isLiked, String text) {
                            var color = isLiked ? Colors.black : Colors.black;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "0",
                                style: TextStyle(
                                    color: color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              result = Text(
                                text,
                                style: TextStyle(
                                    color: color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                            return result;
                          },
                        ),
                        SizedBox(
                          width: GapSize.xxxSmall,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 26,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: GapSize.xxxSmall,
                            ),
                            Text(
                              '${controller.board.value?.commentCnt ?? 0}',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // InkWell(
                        //   onTap: (){
                        //
                        //   },
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.report_rounded,
                        //         size: 26,
                        //         color: Colors.redAccent,
                        //       ),
                        //       SizedBox(
                        //         width: CommonGap.xxxs,
                        //       ),
                        //       Text(
                        //         '신고하기',
                        //         style: TextStyle(
                        //             fontSize: 10,
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height:Get.height / 10,
                      width: Get.width,
                      child: const Center(child: BannerAdWidget()),
                    ),
                    const Divider(),
                    SizedBox(
                      height: GapSize.xxxSmall,
                    ),
                    ...boardController.comment.map((board) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: GapSize.xxxSmall,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: GapSize.xxxSmall,
                                    ),
                                    Text(
                                      board.nickName ?? 'Anonymous',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    const SizedBox(
                                      width: GapSize.xxSmall,
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: null,
                                      board.comment.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible:
                                      controller.auth.user!.uid == board.uid &&
                                          board.useYn == true,
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            controller.commentErase(
                                                controller.board.value?.boardId
                                                    as int,
                                                board.commentId as int);
                                          },
                                          child: const Icon(
                                            EvaIcons.moreHorizontalOutline,
                                            size: 14,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: GapSize.xxSmall,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  board.createDate.toString(),
                                  style: const TextStyle(
                                      fontSize: 8, color: Colors.grey),
                                ),
                                LikeButton(
                                  size: 20,
                                  circleColor: CircleColor(
                                      start: Colors.blueAccent,
                                      end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  isLiked: board.isLike == 1,
                                  onTap: (bool isLiked) {
                                    return controller.saveCommentLike(
                                        controller.board.value?.boardId as int,
                                        controller.board.value
                                            ?.boardCategoryId as int,
                                        board.commentId as int,
                                        isLiked);
                                  },
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      isLiked
                                          ? Icons.thumb_up
                                          : Icons.thumb_up_alt_outlined,
                                      color: isLiked
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      size: 20,
                                    );
                                  },
                                  likeCount: board.commentLikeCnt,
                                  countBuilder:
                                      (int? count, bool isLiked, String text) {
                                    var color =
                                        isLiked ? Colors.black : Colors.black;
                                    Widget result;
                                    if (count == 0) {
                                      result = Text(
                                        "0",
                                        style: TextStyle(
                                            color: color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else
                                      result = Text(
                                        text,
                                        style: TextStyle(
                                            color: color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      );
                                    return result;
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        )),
                    SizedBox(
                      height: GapSize.xSmall,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12),
                        controller: comment,
                        maxLength: 28,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "댓글을 입력해주세요.",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //Get.to(() => BoardUpdatePage());
                        controller.writeComment(-1, comment.text);
                        comment.text = '';
                      },
                      icon: const Icon(
                        // EvaIcons.arrowRightOutline,
                        Icons.comment,
                        color: Colors.blueAccent,
                        size: 30,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
