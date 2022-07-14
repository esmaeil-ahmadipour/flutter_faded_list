library flutter_faded_list;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// [FadedHorizontalList] , this widget used for  display a list of your widgets with the blurred image in the first item.
class FadedHorizontalList extends StatefulWidget {
  const FadedHorizontalList(
      {Key? key,
      required this.children,
      required this.imageWidget,
      this.borderRadius = 16.0,
      this.isDisabledGlow = false,
      this.scrollPhysics = const ScrollPhysics(),
      required this.blankSpaceWidth,
      this.headerWidget,
      required this.bodyColor,
      this.headerColor,
      this.minOpacityOnImage = 0.2})
      : assert(!(blankSpaceWidth < 0),
            '\nYou set the negative value in blankSpaceWidth at FadedHeaderWidget class! ,\nIf you do not need blankSpaceWidth, just set the value to zero.'),
        assert(!(borderRadius < 0),
            '\nYou set the negative value in borderRadius at FadedHeaderWidget class! ,\nIf you do not need borderRadius, just set the value to zero.'),
        assert(!(minOpacityOnImage > 1.0 || minOpacityOnImage < 0.0),
            '\nYou set the minOpacityOnImage value out of range at FadedHeaderWidget class!.\nminOpacityOnImage value must between 0.0 and 1.0 .'),
        super(key: key);

  /// [children] , this widget list used as content and will be scrolled .
  final List<Widget> children;

  /// [imageWidget] , this widget used as background (like image , image network , cachedImage , svg & ETC)
  final Widget imageWidget;

  /// [borderRadius] , this property used for borderRadius of header-widget and main widget (FadedHorizontalList) .
  final double borderRadius;

  /// [bodyColor] , this property used for background of scrollable-widget .
  final Color bodyColor;

  /// [headerColor] , this property used for background of header widget .
  final Color? headerColor;

  /// [isDisabledGlow] , if this property set on true,then hidden glow by scrolling .
  final bool isDisabledGlow;

  /// [scrollPhysics] , this property used for change scroll mode to bounced like iOS or default in android & etc .
  final ScrollPhysics scrollPhysics;

  /// [blankSpaceWidth] , this property used for blank space on first item of content widget list .
  final double blankSpaceWidth;

  /// [headerWidget] , this property used for some time user want to used customized header-widget  .
  final Widget? headerWidget;

  /// [minOpacityOnImage] , this property must set on double number between 0.0 and  1.0 , this property used for minimum opacity on [imageWidget]   .
  final double minOpacityOnImage;

  @override
  State<FadedHorizontalList> createState() => _FadedHorizontalListState();
}

class _FadedHorizontalListState extends State<FadedHorizontalList> {
  late ScrollController _scrollController;
  final GlobalKey _globalKey = GlobalKey();
  ValueNotifier<double> height = ValueNotifier<double>(0.0);
  ValueNotifier<double> scrollPosition = ValueNotifier<double>(0.0);
  @override
  void initState() {
    dynamic dynamicInstance = SchedulerBinding.instance;

    /// cover difference null-safety on SchedulerBinding in flutter3 and older versions.
    dynamicInstance.addPostFrameCallback((timeStamp) {
      /// set height value for using in image_widget.
      height.value = _globalKey.currentContext!.size!.height;
    });

    /// set _scrollController value for using in singleChildScrollView.
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  /// set listener used for detection scroll position.
  _scrollListener() {
    // print("_scrollPosition:$_scrollPosition");
    if (_scrollController.position.pixels <= widget.blankSpaceWidth) {
      scrollPosition.value = _scrollController.position.pixels < 0
          ? 0
          : _scrollController.position.pixels;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      child: ClipRRect(
        /// this widget handle color and main-size and rounded border  .
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: widget.bodyColor,
          ),
          key: _globalKey,
          child: Stack(
            // mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<double>(
                  valueListenable: height,
                  builder: (context, double data, child) {
                    return Container(
                      /// this widget , handle image , gradiant on image , image fade  .
                      height: data,
                      foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: AlignmentDirectional.centerStart,
                              end: AlignmentDirectional.centerEnd,
                              colors: [Colors.transparent, widget.bodyColor])),
                      child: ValueListenableBuilder<double>(
                          valueListenable: scrollPosition,
                          builder: (context, double data, child) {
                            return Opacity(
                              child: widget.imageWidget,
                              opacity: (data < widget.blankSpaceWidth
                                  ? ((widget.blankSpaceWidth - data) /
                                              widget.blankSpaceWidth) <=
                                          widget.minOpacityOnImage
                                      ? widget.minOpacityOnImage
                                      : ((widget.blankSpaceWidth - data) /
                                          widget.blankSpaceWidth)
                                  : widget.minOpacityOnImage),
                            );
                          }),
                    );
                  }),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.headerWidget != null)
                    Container(
                      /// this widget , handle header-toolbar , and style around of widget .
                      decoration: BoxDecoration(
                        color: widget.headerColor ??
                            widget.bodyColor.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(widget.borderRadius),
                            topRight: Radius.circular(widget.borderRadius)),
                      ),
                      child: widget.headerWidget,
                    ),
                  ScrollConfiguration(
                    /// this widget , handle scroll and scroll-notification , disable scroll-glow , scroll-physics , scroll-direction .
                    behavior: widget.isDisabledGlow
                        ? DisableGlow()
                        : const ScrollBehavior(),
                    child: SingleChildScrollView(
                      physics: widget.scrollPhysics,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: widget.blankSpaceWidth),
                        child: Row(
                          /// this widget , handle children widgets .
                          children: widget.children,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [DisableGlow] ,this widget used for disable glow when user scrolled screen.
class DisableGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

/// [FadedHeaderWidget] , this widget is bonus ! you can set header easily on the FadedHorizontalList widgets.
class FadedHeaderWidget extends StatelessWidget {
  const FadedHeaderWidget({
    Key? key,
    this.title,
    this.buttonTitle,
    this.buttonIcon,
    this.onTap,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 16.0,
  })  : assert(!(verticalPadding < 0 || horizontalPadding < 0),
            '\nYou set the negative value in verticalPadding or horizontalPadding at FadedHeaderWidget class! ,\n If you do not need padding, just set the value to zero.'),
        assert(!(title == null && buttonTitle == null && buttonIcon == null),
            '\nall required values in FadedHeaderWidget class is null ,\n at the least mode just set the title value.'),
        super(key: key);

  /// [title] , by this parameter ,  can  set title on the [FadedHeaderWidget] , for example, as a Text("New Category") widget .
  final Widget? title;

  /// [buttonTitle] , by this parameter ,  can  set buttonTitle on the [FadedHeaderWidget] , for example, as a Text("Show All") widget .
  final Widget? buttonTitle;

  /// [buttonIcon] , by this parameter ,  can  set buttonIcon on the [FadedHeaderWidget] , for example, as a Icon(Icons.arrow_forward_outlined) widget .
  final Widget? buttonIcon;

  /// [onTap] , by this parameter ,  can  set Function  onTap on the [FadedHeaderWidget] , for example, when tap on ths [buttonTitle] or [buttonIcon] running this function .
  final Function()? onTap;

  /// [verticalPadding]  , used for padding vertically into [FadedHeaderWidget].
  final double verticalPadding;

  ///  [horizontalPadding] , used for padding horizontally into [FadedHeaderWidget].
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (title != null) title!,
              const Spacer(),
              if (buttonTitle != null || buttonIcon != null)
                GestureDetector(
                  onTap: onTap ?? () {},
                  child: Row(
                    children: [
                      if (buttonTitle != null) buttonTitle!,
                      if (buttonIcon != null) buttonIcon!
                    ],
                  ),
                )
            ],
          ),
        ),
        const Divider(height: 0.0),
      ],
    );
  }
}
