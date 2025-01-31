import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jhentai/src/utils/screen_size_util.dart';

import '../../../../model/gallery_image.dart';
import '../../../../setting/read_setting.dart';
import '../base/base_layout_logic.dart';
import 'horizontal_double_column_layout_state.dart';

class HorizontalDoubleColumnLayoutLogic extends BaseLayoutLogic {
  @override
  HorizontalDoubleColumnLayoutState state = HorizontalDoubleColumnLayoutState();

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: readPageState.readPageInfo.initialIndex ~/ 2);

    /// record reading progress and sync thumbnails list index
    pageController.addListener(_readProgressListener);
  }

  @override
  void toLeft() {
    if (ReadSetting.readDirection.value == ReadDirection.left2right) {
      toPrev();
    } else {
      toNext();
    }
  }

  @override
  void toRight() {
    if (ReadSetting.readDirection.value == ReadDirection.left2right) {
      toNext();
    } else {
      toPrev();
    }
  }

  @override
  void toPrev() {
    int targetIndex = ((pageController.page! - 1) * 2).toInt();
    toPageIndex(max(targetIndex, 0));
  }

  @override
  void toNext() {
    int targetIndex = ((pageController.page! + 1) * 2).toInt();
    toPageIndex(min(targetIndex, readPageState.readPageInfo.pageCount));
  }

  @override
  void jump2PageIndex(int imageIndex) {
    pageController.jumpToPage((imageIndex + 1) ~/ 2);
    super.jump2PageIndex(imageIndex);
  }

  @override
  void scroll2PageIndex(int imageIndex, [Duration? duration]) {
    pageController.animateToPage(
      (imageIndex + 1) ~/ 2,
      duration: duration ?? const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    super.scroll2PageIndex((imageIndex + 1) ~/ 2, duration);
  }

  @override
  void enterAutoMode() {
    _enterAutoModeByTurnPage();
  }

  void _enterAutoModeByTurnPage() {
    readPageLogic.toggleMenu();

    autoModeTimer = Timer.periodic(
      Duration(milliseconds: (ReadSetting.autoModeInterval.value * 1000).toInt()),
      (_) {
        /// changed read setting
        if (ReadSetting.readDirection.value == ReadDirection.top2bottom || ReadSetting.enableDoubleColumn.isFalse) {
          Get.engine.addPostFrameCallback((_) {
            readPageLogic.closeAutoMode();
          });
          autoModeTimer?.cancel();
          return;
        }

        /// stop when at last
        if (readPageState.readPageInfo.currentIndex == readPageState.readPageInfo.pageCount - 1) {
          Get.engine.addPostFrameCallback((_) {
            readPageLogic.closeAutoMode();
          });
          autoModeTimer?.cancel();
          return;
        }

        toNext();
      },
    );
  }

  void _readProgressListener() {
    int currentPage = pageController.page!.toInt();
    readPageLogic.recordReadProgress(currentPage * 2);
    readPageLogic.syncThumbnails(currentPage * 2);
  }

  @override
  Size getPlaceHolderSize() {
    /// 6 is the width of divider
    return Size((fullScreenWidth - 6) / 2, double.infinity);
  }

  @override
  FittedSizes getImageFittedSize(GalleryImage image) {
    /// 6 is the width of divider
    return applyBoxFit(
      BoxFit.contain,
      Size(image.width, image.height),
      Size((fullScreenWidth - 6) / 2, screenHeight),
    );
  }
}
