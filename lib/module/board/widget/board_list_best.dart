import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/model/board_model.dart';
import 'package:oru_rock/module/board/board_controller.dart';
import '../../app/app.dart';
import 'board_detail_loading.dart';
import '../board_update.dart';

class BoardListBest extends GetView<BoardController> {
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    var refreshKey = GlobalKey<RefreshIndicatorState>();
    return Obx(
      () => controller.bestBoardList.isEmpty
          ? Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async {
                      controller.boardPage = 1;
                      await controller.getBoardList();
                    },
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height / 4),

                              const Icon(
                                EvaIcons.fileTextOutline,
                                size: 50,
                              ),
                              const SizedBox(
                                height: GapSize.medium,
                              ),
                              const Text('게시물이 없습니다.'),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(GapSize.medium),
                            child: FloatingActionButton(
                              onPressed: () {
                                Get.to(() => BoardUpdatePage());
                                controller.board.value = BoardModel();
                              },
                              child: const Icon(Icons.add),
                              backgroundColor: Colors.indigoAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async {
                      controller.bestBoardPage = 1;
                      await controller.getBestBoardList();
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      controller: controller.bestBoardScrollController,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: controller.bestBoardList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.getBoardDetail(
                                controller.bestBoardList[index].boardId!,
                                controller.selectedBoardCategory.value);
                            Get.to(() => BoardDetailLoading());
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: GapSize.xxxSmall,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${controller.bestBoardList[index].author}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'Malgun Gothic'),
                                                ),
                                                const SizedBox(
                                                  width: GapSize.xxxSmall,
                                                ),
                                                Text(
                                                  "${controller.bestBoardList[index].createDate}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                      fontFamily:
                                                          'Malgun Gothic'
                                                      // fontStyle: FontStyle.italic,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: GapSize.small,
                                ),
                                Text(
                                  "${controller.bestBoardList[index].subject}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Malgun Gothic'),
                                ),
                                const SizedBox(
                                  height: GapSize.xxxSmall,
                                ),
                                Text(
                                  controller.bestBoardList[index].content ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'Malgun Gothic'),
                                ),
                                const SizedBox(
                                  height: GapSize.small,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          EvaIcons.heart,
                                          size: 20,
                                          color: Colors.redAccent,
                                        ),
                                        const SizedBox(
                                          width: GapSize.xxxSmall,
                                        ),
                                        Text(
                                          "${controller.bestBoardList[index].recommendCnt} ",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontFamily: 'Malgun Gothic'
                                              // fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.comment, size: 18),
                                        const SizedBox(
                                          width: GapSize.xxxSmall,
                                        ),
                                        Text(
                                          '${controller.bestBoardList[index].commentCnt ?? 0}',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontFamily: 'Malgun Gothic'),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: GapSize.xxxSmall,
                                        ),
                                        Text(
                                          "${controller.bestBoardList[index].views}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontFamily: 'Malgun Gothic'
                                              // fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
