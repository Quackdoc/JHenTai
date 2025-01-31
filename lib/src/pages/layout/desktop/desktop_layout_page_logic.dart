import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/ui_config.dart';
import '../../../service/windows_service.dart';
import '../../home_page.dart';
import 'desktop_layout_page_state.dart';

class DesktopLayoutPageLogic extends GetxController {
  final String tabBarId = 'tabBarId';
  final String leftColumnId = 'leftColumnId';

  DesktopLayoutPageState state = DesktopLayoutPageState();

  final WindowService windowService = Get.find<WindowService>();

  @override
  void onInit() {
    super.onInit();
    state.leftColumnWidthRatio = windowService.leftColumnWidthRatio;
  }

  @override
  void onClose() {
    state.leftTabBarFocusScopeNode.dispose();
    state.leftColumnFocusScopeNode.dispose();
    state.rightColumnFocusScopeNode.dispose();
    super.onClose();
  }

  /// tap another bar -> change index
  /// at gallery bar and tap gallery bar again -> scroll to top
  /// at gallery bar and tap gallery bar twice -> scroll to top and refresh
  void handleTapTabBarButton(int index) {
    state.icons[index].shouldRender = true;

    int prevIndex = state.selectedTabIndex;
    state.selectedTabIndex = index;

    if (prevIndex != index) {
      leftRouting.args = null;
      Get.parameters = {};
      update([tabBarId, leftColumnId]);
      return;
    }

    ScrollController? scrollController = state.scrollControllers[index];

    /// no popular_page.dart data
    if ((scrollController?.hasClients ?? false) == false) {
      return;
    }

    /// scroll to top
    if (scrollController?.offset != 0) {
      scrollController?.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }

    if (state.lastTapTime == null) {
      state.lastTapTime = DateTime.now();
      return;
    }

    if (DateTime.now().difference(state.lastTapTime!).inMilliseconds <= 200) {
      Future.delayed(
        const Duration(milliseconds: 0),

        /// default value equals to CupertinoSliverRefreshControl._defaultRefreshTriggerPullDistance
        () => scrollController?.animateTo(
          -UIConfig.refreshTriggerPullDistance,
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
      );
    }

    state.lastTapTime = DateTime.now();
  }
}
