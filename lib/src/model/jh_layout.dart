import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LayoutMode {
  mobile,
  tablet,
  desktop,
  mobileV2,
  tabletV2,
}

class JHLayout {
  final LayoutMode mode;

  final String name;

  final String desc;

  final ValueGetter<bool> isSupported;

  JHLayout({
    required this.mode,
    required this.name,
    required this.desc,
    required this.isSupported,
  });

  static List<JHLayout> get allLayouts => [
        JHLayout(
          mode: LayoutMode.mobileV2,
          name: 'mobileLayoutV2Name'.tr,
          desc: 'mobileLayoutV2Desc'.tr,
          isSupported: () => true,
        ),
        JHLayout(
          mode: LayoutMode.mobile,
          name: 'mobileLayoutName'.tr,
          desc: 'mobileLayoutDesc'.tr,
          isSupported: () => true,
        ),
        JHLayout(
          mode: LayoutMode.tabletV2,
          name: 'tabletLayoutV2Name'.tr,
          desc: 'tabletLayoutV2Desc'.tr,
          isSupported: () => WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio >= 600,
        ),
        JHLayout(
          mode: LayoutMode.tablet,
          name: 'tabletLayoutName'.tr,
          desc: 'tabletLayoutDesc'.tr,
          isSupported: () => WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio >= 600,
        ),
        JHLayout(
          mode: LayoutMode.desktop,
          name: 'desktopLayoutName'.tr,
          desc: 'desktopLayoutDesc'.tr,
          isSupported: () => WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio >= 600,
        ),
      ];
}
