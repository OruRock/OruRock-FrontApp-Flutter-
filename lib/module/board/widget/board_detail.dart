import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('커뮤니티',),
          actions: [
            Visibility(
              visible: controller.auth.user!.uid! ==
                  controller.board.value?.uid,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.board.value?.subject ?? '',
                          style: const TextStyle(
                              fontFamily: "NotoB", fontSize: FontSize.xxLarge),
                        ),
                        const SizedBox(
                          height: GapSize.xSmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.board.value?.author ?? ' ',
                              style: const TextStyle(
                                  fontFamily: "NotoR",
                                  fontSize: FontSize.small),
                            ),
                            const SizedBox(
                              width: GapSize.xxSmall,
                            ),
                            Text(
                              '${controller.board.value?.createDate}' ??
                                  '',
                              style: const TextStyle(fontSize: FontSize.xxSmall, fontFamily: "NotoR", color: Colors.grey),
                            ),
                            Expanded(child: Container()),
                            const Icon(Icons.remove_red_eye,
                                size: 12, color: Colors.grey,),
                            Text(
                              ' ${controller.board.value?.views ?? 0}',
                              style: const TextStyle(
                                  fontSize: FontSize.xxSmall,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: GapSize.xxxSmall,
                        )
                      ],
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: GapSize.xSmall),
                      child: Text(controller.board.value?.content ?? ''),
                    ),
                    const SizedBox(
                      height: GapSize.xxLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LikeButton(
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
                              size: 25,
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
                        const SizedBox(
                          width: GapSize.xSmall,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.comment_outlined,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: GapSize.xxxSmall,
                            ),
                            Text(
                              '${controller.board.value?.commentCnt ?? 0}',
                              style: const TextStyle(
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: GapSize.small),
                      child: BannerAdWidget(),
                    ),
                    const Divider(height: 1,),
                    ...controller.comment.map((board) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: GapSize.medium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  board.nickName ?? 'Anonymous',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSize.xSmall),
                                ),
                                const SizedBox(
                                  width: GapSize.xxSmall,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: null,
                                  board.createDate!,
                                  style: const TextStyle(fontSize: FontSize.xxSmall, fontFamily: "NotoM", color: Colors.grey),
                                ),
                                Expanded(child: Container()),
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
                            const SizedBox(
                              height: GapSize.xxSmall,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  board.comment!,
                                  style: const TextStyle(
                                      fontSize: FontSize.small, color: Colors.black, fontFamily: "NotoR"),
                                ),
                                LikeButton(
                                  circleColor: const CircleColor(
                                      start: Colors.blueAccent,
                                      end: Color(0xff0099cc)),
                                  bubblesColor: const BubblesColor(
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
                                    Widget result;
                                    if (count == 0) {
                                      result = const Text(
                                        "0",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: FontSize.xSmall,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else {
                                      result = Text(
                                        text,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: FontSize.xSmall,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                    return result;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: GapSize.small,
                            ),
                            const Divider(height: 1,),
                          ],
                        )),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(fontSize: 12),
                      controller: comment,
                      decoration: InputDecoration(
                        hintText: "댓글을 입력해주세요.",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.writeComment(-1, comment.text);
                        comment.text = '';
                      },
                      icon: const Icon(
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
