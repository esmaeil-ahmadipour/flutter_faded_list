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
      this.border,
      this.isDisabledGlow = false,
      this.scrollPhysics = const ScrollPhysics(),
      required this.blankSpaceWidth,
      this.headerWidget,
      required this.bodyColor,
      this.headerColor})
      : assert(!(blankSpaceWidth < 0),
            'You set the negative value in blankSpaceWidth at FadedHeaderWidget class! , If you do not need blankSpaceWidth, just set the value to zero.'),
        assert(!(borderRadius < 0),
            'You set the negative value in borderRadius at FadedHeaderWidget class! , If you do not need borderRadius, just set the value to zero.'),
        super(key: key);
  final List<Widget> children;
  final Widget imageWidget;
  final double borderRadius;
  final Border? border;
  final Color bodyColor;
  final Color? headerColor;
  final bool isDisabledGlow;
  final ScrollPhysics scrollPhysics;
  final double blankSpaceWidth;
  final Widget? headerWidget;

  @override
  State<FadedHorizontalList> createState() => _FadedHorizontalListState();
}

class _FadedHorizontalListState extends State<FadedHorizontalList> {
  late ScrollController _scrollController;
  double height = 0.0;
  final GlobalKey _globalKey = GlobalKey();
  double _scrollPosition = 0.0;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        /// set height value for using in image_widget.
        height = _globalKey.currentContext!.size!.height;
      });
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
      setState(() {
        _scrollPosition = _scrollController.position.pixels < 0
            ? 0
            : _scrollController.position.pixels;
      });
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
            Container(
              /// this widget , handle image , gradiant on image , image fade  .
              height: height,
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [Colors.transparent, widget.bodyColor])),
              child: Opacity(
                child: widget.imageWidget,
                opacity: (_scrollPosition < widget.blankSpaceWidth
                    ? ((widget.blankSpaceWidth - _scrollPosition) /
                                widget.blankSpaceWidth) <=
                            0.2
                        ? 0.2
                        : ((widget.blankSpaceWidth - _scrollPosition) /
                            widget.blankSpaceWidth)
                    : 0.2),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.headerWidget != null)
                  Container(
                    /// this widget , handle header-toolbar , and style around of widget .
                    decoration: BoxDecoration(
                      color: widget.headerColor ??
                          widget.bodyColor.withOpacity(0.5),
                      border: widget.border,
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
    ));
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
            'You set the negative value in verticalPadding or horizontalPadding at FadedHeaderWidget class! , If you do not need padding, just set the value to zero.'),
        assert(!(title == null && buttonTitle == null && buttonIcon == null),
            'all required values in FadedHeaderWidget class is null , at the least mode just set the title value.'),
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
        const Divider(height: 0),
      ],
    );
  }
}
