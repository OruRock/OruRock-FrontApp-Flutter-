import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/board/board_controller.dart';
import 'package:oru_rock/module/board/widget/board_detail.dart';
import 'package:shimmer/shimmer.dart';

class BoardDetailLoading extends GetView<BoardController> {

  const BoardDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final comment = TextEditingController();
    BoardController boardController = Get.put(BoardController());

    return Obx(
      () => controller.enabled.value
          ? Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('커뮤니티'),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            controller: controller.scrollController,
                            shrinkWrap: true,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            children: [
                              _buildTopMenuShimmerLayout(),
                              const SizedBox(
                                height: GapSize.small,
                              ),
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                height: GapSize.small,
                              ),
                              _buildContentShimmerLayout(),
                              const SizedBox(
                                height: GapSize.medium,
                              ),
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: Colors.grey[100],
                              ),
                              const SizedBox(
                                height: GapSize.xxxSmall,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildCommentShimmerLayout(),
                                  _buildCommentShimmerLayout(),
                                  _buildCommentShimmerLayout(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          : BoardDetail(),
    );
  }

  _buildContentShimmerLayout() {
    return Column(
      children: [
        Container(
          height: GapSize.small,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(RadiusSize.small),
            border: Border.all(color: Colors.white, width: 3),
          ),
        ),
        const SizedBox(
          height: GapSize.small,
        ),
        Container(
          height: GapSize.small,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(RadiusSize.small),
            border: Border.all(color: Colors.white, width: 3),
          ),
        ),
        const SizedBox(
          height: GapSize.small,
        ),
        Container(
          height: GapSize.small,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(RadiusSize.small),
            border: Border.all(color: Colors.white, width: 3),
          ),
        ),
        const SizedBox(
          height: GapSize.small,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: GapSize.small,
            width: WidthWithRatio.xxxLarge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RadiusSize.small),
            ),
          ),
        ),
        SizedBox(height: HeightWithRatio.medium),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: GapSize.large,
            width: WidthWithRatio.xLarge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RadiusSize.small),
            ),
          ),
        ),
      ],
    );
  }

  _buildTopMenuShimmerLayout() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: GapSize.large,
            width: WidthWithRatio.xxxLarge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RadiusSize.small),
            ),
          ),
        ),
        const SizedBox(
          height: GapSize.small,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: GapSize.xxSmall,
              width: WidthWithRatio.xLarge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RadiusSize.small),
              ),
            ),
            Container(
              height: GapSize.xxSmall,
              width: WidthWithRatio.small,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RadiusSize.small),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildCommentShimmerLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: GapSize.small,
        ),
        Row(
          children: [
            Container(
              height: GapSize.xSmall,
              width: WidthWithRatio.large,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RadiusSize.small),
              ),
            ),
            const SizedBox(
              width: GapSize.medium,
            ),
            Container(
              height: GapSize.small,
              width: WidthWithRatio.xxxLarge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RadiusSize.small),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: GapSize.large,
              width: WidthWithRatio.medium,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RadiusSize.small),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: GapSize.xxSmall,
        ),
        Container(
          height: GapSize.xxSmall,
          width: WidthWithRatio.medium,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(RadiusSize.small),
          ),
        ),
        const SizedBox(
          height: GapSize.small,
        ),
        Divider(
          height: 1.0,
          thickness: 1.0,
          color: Colors.grey[100],
        ),
      ],
    );
  }
}
