import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/src/helper/config.dart';
import 'package:flutter_smart_dialog/src/helper/dialog_proxy.dart';
import 'package:flutter_smart_dialog/src/strategy/action.dart';
import 'package:flutter_smart_dialog/src/widget/smart_dialog_view.dart';

///main function : custom dialog
class DialogStrategy extends DialogAction {
  DialogStrategy({
    required Config config,
    required OverlayEntry overlayEntry,
  }) : super(config: config, overlayEntry: overlayEntry);

  @override
  Future<void> show({
    required Widget widget,
    AlignmentGeometry? alignment,
    bool? isPenetrate,
    bool? isUseAnimation,
    Duration? animationDuration,
    bool? isLoading,
    Color? maskColor,
    Widget? maskWidget,
    bool? clickBgDismiss,
    VoidCallback? onDismiss,
    SmartDialogVoidCallBack? onBgTap,
  }) async {
    config.isExist = true;
    config.isExistMain = true;

    return mainAction.show(
      widget: widget,
      alignment: alignment,
      isPenetrate: isPenetrate,
      isUseAnimation: isUseAnimation,
      animationDuration: animationDuration,
      isLoading: isLoading,
      maskColor: maskColor,
      maskWidget: maskWidget,
      clickBgDismiss: clickBgDismiss,
      onDismiss: onDismiss,
      onBgTap: () => onBgTap == null ? dismiss() : onBgTap(),
    );
  }

  @override
  Future<void> dismiss() async {
    await mainAction.dismiss();
    if (DialogProxy.instance.dialogList.length != 0) return;

    config.isExistMain = false;
    if (!config.isExistLoading) {
      config.isExist = false;
    }
  }
}
