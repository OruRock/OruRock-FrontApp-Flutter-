import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/board_model.dart';
import 'package:oru_rock/module/board/board_controller.dart';

import '../board_update.dart';
import 'board_detail_loading.dart';

class BoardListNew extends GetView<BoardController> {
  const BoardListNew({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    var refreshKey = GlobalKey<RefreshIndicatorState>();
    return Obx(
      () => controller.boardList.isEmpty
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
                              backgroundColor: Colors.indigoAccent,
                              child: const Icon(Icons.add),
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
                      controller.boardPage = 1;
                      await controller.getBoardList();
                    },
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: controller.boardScrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: controller.boardList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: GapSize.small, vertical: GapSize.xxxSmall * 0.75),
                              child: InkWell(
                                onTap: () {
                                  controller.getBoardDetail(
                                      controller.boardList[index].boardId!,
                                      controller.selectedBoardCategory.value);
                                  Get.to(() => const BoardDetailLoading());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
                                  width: Get.width * 0.8,
                                  height: Get.height * 0.075,
                                  decoration: shadowBoxDecoration,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${controller.boardList[index].subject}",
                                        style: const TextStyle(
                                            fontSize: FontSize.medium,
                                            color: Colors.black,
                                            fontFamily: 'NotoB'),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.boardList[index].createDate}",
                                                style: const TextStyle(
                                                    fontSize: FontSize.xxSmall,
                                                    color: Colors.grey,
                                                    fontFamily: 'NotoM' // fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              Text(
                                                " | ${controller.boardList[index].author}",
                                                style: const TextStyle(
                                                    fontSize: FontSize.xxSmall,
                                                    color: Colors.grey,
                                                    fontFamily: 'NotoM'
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              _buildBottomIcon(
                                                  icon: const Icon(Icons.remove_red_eye,
                                                      size: 12),
                                                  count:
                                                  "${controller.boardList[index].views}"
                                              ),
                                              _buildBottomIcon(
                                                  icon: const Icon(Icons.comment,
                                                      size: 12),
                                                  count:
                                                  '${controller.boardList[index].commentCnt ?? 0}'
                                              ),
                                              _buildBottomIcon(
                                                  icon: const Icon(
                                                    EvaIcons.heart,
                                                    size: 14,
                                                    color: Colors.redAccent,
                                                  ),
                                                  count:
                                                  "${controller.boardList[index].recommendCnt}"
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  /*ListTile(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${controller.boardList[index].author}",
                                          style: const TextStyle(
                                              fontSize: FontSize.xSmall,
                                              color: Colors.black,
                                              fontFamily: 'NotoB'),
                                        ),
                                        const SizedBox(
                                          width: GapSize.xxSmall,
                                        ),
                                        Text(
                                          "${controller.boardList[index].createDate}",
                                          style: const TextStyle(
                                              fontSize: FontSize.xxSmall,
                                              color: Colors.grey,
                                              fontFamily: 'NotoB'
                                              // fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: GapSize.small),
                                          child: Text(
                                            "${controller.boardList[index].subject}",
                                            style: const TextStyle(
                                                fontSize: FontSize.large,
                                                color: Colors.black,
                                                fontFamily: 'NotoR'),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: GapSize.small,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            _buildBottomIcon(
                                                icon: const Icon(
                                                  EvaIcons.heart,
                                                  size: 20,
                                                  color: Colors.redAccent,
                                                ),
                                                count:
                                                    "${controller.boardList[index].recommendCnt}"),
                                            _buildBottomIcon(
                                                icon: const Icon(Icons.comment,
                                                    size: 18),
                                                count:
                                                    '${controller.boardList[index].commentCnt ?? 0}'),
                                            _buildBottomIcon(
                                                icon: const Icon(Icons.remove_red_eye,
                                                    size: 18),
                                                count:
                                                    "${controller.boardList[index].views}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),*/
                                ),
                              ),
                            );
                          },
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
                              backgroundColor: Colors.indigoAccent,
                              child: const Icon(Icons.add),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _buildBottomIcon({required Widget icon, required String count}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: GapSize.xxSmall,
        ),
        icon,
        const SizedBox(
          width: GapSize.xxSmall,
        ),
        Text(
          count,
          style: const TextStyle(
              fontSize: FontSize.xxSmall, color: Colors.grey, fontFamily: 'NotoR'
              // fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }
}
