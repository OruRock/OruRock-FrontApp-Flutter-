import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/helper/nickname_checker.dart';
import 'package:oru_rock/module/board/board_controller.dart';
import 'package:oru_rock/module/board/widget/board_list_best.dart';
import 'package:oru_rock/module/board/widget/board_list_loading.dart';
import 'package:oru_rock/module/board/widget/board_list_new.dart';
import 'package:shimmer/shimmer.dart';

import '../app/app_controller.dart';

class BoardList extends GetView<BoardController> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _tabKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Obx(() => DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Obx(() => Text(
                    controller.boardTitle.value,
                  )),
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                    controller.searchInputBoxNode.unfocus();
                  },
                  color: Colors.black,
                  icon: const Icon(
                    EvaIcons.menu,
                    size: 30,
                  )),
              actions: [
                IconButton(
                    onPressed: () {
                      controller.showSearchBox();
                    },
                    color: Colors.black,
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    )),
              ],
              bottom: PreferredSize(
                preferredSize: const Size(24, 24),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 1,
                  indicatorColor: Colors.black12,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '홈',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'Malgun Gothic'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '인기',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'Malgun Gothic'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: GapSize.small,
                  ),
                  controller.search.value == true
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: GapSize.medium, right: GapSize.medium),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 12),
                            controller: controller.searchTxtController,
                            focusNode: controller.searchInputBoxNode,
                            decoration: InputDecoration(
                              hintText: "검색어를 입력해주세요.",
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  if (DefaultTabController.of(controller.context
                                              as BuildContext)
                                          ?.index ==
                                      0) {
                                    controller.getBoardList();
                                  } else {
                                    controller.getBestBoardList();
                                  }
                                },
                              ),
                              prefixIcon: InkWell(
                                  onTap: () {
                                    controller.searchTxtController.clear();
                                    if (DefaultTabController.of(controller
                                                .context as BuildContext)
                                            ?.index ==
                                        0) {
                                      controller.getBoardList();
                                    } else {
                                      controller.getBestBoardList();
                                    }
                                  },
                                  child: const Icon(
                                    EvaIcons.arrowLeftOutline,
                                    color: Colors.blueAccent,
                                    size: 30,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: validateComment(),
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: controller.enabled.value
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: TabBarView(
                              children: [
                                BoardListLoading(),
                                BoardListLoading()
                              ],
                            ),
                          )
                        : TabBarView(
                            children: [BoardListNew(), BoardListBest()],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
