/*
 * Copyright (c) 2020 Pawan Kumar. All rights reserved.
 *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  * http://www.apache.org/licenses/LICENSE-2.0
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../velocity_x.dart';

extension WidgetsExtension on Widget {
  ///Tooltip as accessibility
  Widget tooltip(String message,
          {Key key,
          Decoration decoration,
          double height,
          bool preferBelow,
          EdgeInsetsGeometry padding,
          TextStyle textStyle,
          Duration waitDuration,
          EdgeInsetsGeometry margin}) =>
      Tooltip(
        key: key,
        message: message,
        decoration: decoration,
        height: height,
        padding: padding,
        preferBelow: preferBelow,
        textStyle: textStyle,
        waitDuration: waitDuration,
        margin: margin,
        child: this,
      );

  ///Hides a widget
  Widget hide({Key key, bool isVisible = false, bool maintainSize = false}) =>
      Visibility(
        key: key,
        child: this,
        visible: isVisible,
        maintainSize: maintainSize,
        maintainAnimation: maintainSize,
        maintainState: maintainSize,
      );

  ///Hides a widget
  Widget popupMenu(
    MenuBuilderCallback menuBuilder, {
    Key key,
    VxPopupMenuController controller,
    Color arrowColor = const Color(0xFF4C4C4C),
    double arrowSize = 10.0,
    Color barrierColor = Colors.black12,
    double horizontalMargin = 10.0,
    double verticalMargin = 10.0,
    bool showArrow = true,
    VxClickType clickType = VxClickType.singleClick,
  }) =>
      VxPopupMenu(
        key: key,
        child: this,
        clickType: clickType,
        controller: controller,
        arrowColor: arrowColor,
        arrowSize: arrowSize,
        barrierColor: barrierColor,
        horizontalMargin: horizontalMargin,
        showArrow: showArrow,
        verticalMargin: verticalMargin,
        menuBuilder: menuBuilder,
      );

  /// Widget to show exception
  Widget errorWidget(Object ex) => ErrorWidget(ex);

  /// Extension for [Expanded]
  Expanded expand({Key key, int flex = 1}) {
    return Expanded(
      key: key,
      flex: flex,
      child: this,
    );
  }

  /// Extension for coloring a widget with [DecoratedBox]
  DecoratedBox backgroundColor(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
      ),
      child: this,
    );
  }

  /// Extension for adding a corner radius a widget with [ClipRRect]
  ClipRRect cornerRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  /// Extension for keepAlive
  Widget keepAlive() {
    return _KeepAliveWidget(this);
  }

  ///it is very like onTap extension but when you put your finger on it, its color will change,
  ///and you can decide that whether it will have a touchFeedBack (vibration on your phone)
  ///

  Widget onFeedBackTap(VoidCallback onTap,
      {HitTestBehavior hitTestBehavior = HitTestBehavior.deferToChild,
      bool touchFeedBack = false}) {
    return _CallbackButton(
      child: this,
      onTap: onTap,
      needHaptic: touchFeedBack,
      hitTestBehavior: hitTestBehavior,
    );
  }

  CupertinoPageRoute cupertinoRoute({bool fullscreenDialog = false}) {
    /// Example:
    /// Navigator.push(context, YourPage().cupertinoRoute());
    ///
    return CupertinoPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (ctx) {
          return this;
        });
  }

  MaterialPageRoute materialRoute({bool fullscreenDialog = false}) {
    return MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (ctx) {
          return this;
        });
  }
}

extension StringWidgetsExtension on String {
  Widget circularAssetImage(
          {Key key,
          double radius = 35.0,
          Color bgColor = Colors.white,
          Color fgColor,
          Widget child}) =>
      CircleAvatar(
        key: key,
        radius: radius,
        backgroundColor: bgColor,
        child: child,
        foregroundColor: fgColor,
        backgroundImage: AssetImage(this),
      );

  Widget circlularNetworkImage(
          {Key key,
          double radius = 65.0,
          Color bgColor = Colors.white,
          Color fgColor,
          Widget child}) =>
      CircleAvatar(
        key: key,
        radius: radius,
        backgroundColor: bgColor,
        child: child,
        foregroundColor: fgColor,
        backgroundImage: NetworkImage(
          this,
        ),
      );

  Widget circularAssetShadowImage({
    Key key,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(0.0),
    double width = 40.0,
    double height = 40.0,
    double blurRadius = 3.0,
    double borderRadius = 50.0,
  }) =>
      Container(
        key: key,
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          image: DecorationImage(image: AssetImage(this)),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: blurRadius,
              offset: const Offset(
                0.0,
                0.0,
              ),
            )
          ],
        ),
      );
}

class _KeepAliveWidget extends StatefulWidget {
  final Widget child;

  const _KeepAliveWidget(this.child);

  @override
  State<StatefulWidget> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<_KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

class _CallbackButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color normalColor;
  final Color pressedColor;
  final bool needHaptic;
  final HitTestBehavior hitTestBehavior;

  const _CallbackButton(
      {Key key,
      this.onTap,
      this.child,
      this.normalColor = Colors.transparent,
      this.pressedColor = Colors.black12,
      this.needHaptic = false,
      this.hitTestBehavior})
      : super(key: key);

  @override
  _CallbackButtonState createState() => _CallbackButtonState();
}

class _CallbackButtonState extends State<_CallbackButton> {
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.hitTestBehavior,
      onTap: widget.onTap,
      onTapDown: handleTapDown,
      onTapUp: handleTapUp,
      onTapCancel: handleCancel,
      child: Container(
        color: bgColor,
        child: widget.child,
      ),
    );
  }

  void handleTapDown(TapDownDetails tapDownDetails) {
    setState(() {
      bgColor = widget.pressedColor;
    });
  }

  void handleCancel() {
    setState(() {
      bgColor = widget.normalColor;
    });
  }

  void handleTapUp(TapUpDetails tapDownDetails) {
    if (widget.needHaptic) {
      HapticFeedback.heavyImpact();
    }
    setState(() {
      bgColor = widget.normalColor;
    });
  }
}

typedef AnimationUpdateCallBack<T> = Function(T value, double percent);

void withAnimation<T>(
    {@required TickerProvider vsync,
    @required Tween<T> tween,
    @required AnimationUpdateCallBack<T> callBack,
    Duration duration = const Duration(seconds: 1),
    double initialValue = 0.0,
    Curve curve = Curves.linear,
    bool isRepeated = false}) {
  final AnimationController controller = AnimationController(
      vsync: vsync, duration: duration, value: initialValue);
  final curveAnimation = CurvedAnimation(parent: controller, curve: curve);
  final Animation animation = tween.animate(curveAnimation);
  animation.addListener(() {
    callBack?.call(animation.value, controller.value);
  });

  if (isRepeated) {
    controller.repeat().whenCompleteOrCancel(() {
      controller.dispose();
    });
  } else {
    controller.forward().whenCompleteOrCancel(() {
      controller.dispose();
    });
  }
}
