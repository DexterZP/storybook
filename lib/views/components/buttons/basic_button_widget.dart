import 'package:flutter/material.dart';
import 'package:storybook/views/components/list_tiles/list_tile_widget.dart';

class PZLButton extends StatelessWidget {
  final Function()? onTap;
  final Widget? leading;
  final Widget child;
  final Widget? trailing;
  final double radius;
  final Color? color;
  final Gradient? gradient;
  final EdgeInsets? padding;
  final bool isDisable;
  final double opacityDisabled;
  //to turn this widget disable
  final MouseCursor cursor;
  final double spacing;
  final Border? border;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final MainAxisSize? mainAxisSize;
  final BoxDecoration? foregroundDecoration;
  final List<BoxShadow>? boxShadow;
  final MainAxisAlignment alignment;
  final Function(bool)? onHover;

  const PZLButton({
    Key? key,
    this.onTap,
    this.leading,
    required this.child,
    this.trailing,
    this.radius = 8,
    this.color,
    this.cursor = SystemMouseCursors.click,
    this.gradient,
    this.padding = const EdgeInsets.all(13),
    this.isDisable = false,
    this.spacing = 16,
    this.border,
    this.borderRadius,
    this.height,
    this.width,
    this.mainAxisSize = MainAxisSize.max,
    this.opacityDisabled = 0.1,
    this.foregroundDecoration,
    this.boxShadow,
    this.alignment = MainAxisAlignment.start,
    this.onHover,
  }) : super(key: key);

  //This is necessary to don`t turn this widget expanded in some cases when have only one widget inside PZLButton
  correctWidget() => (leading == null && trailing == null)
      ? child
      : PZLListTile(
          onTap: onTap,
          leading: leading,
          trailing: trailing,
          spacing: spacing,
          mainAxisSize: mainAxisSize,
          alignment: alignment,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: radius,
      mouseCursor: cursor,
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      onHover: onHover,
      onTap: onTapButton,
      child: Opacity(
        opacity: isDisable ? opacityDisabled : 1,
        child: Container(
          height: height,
          width: width,
          padding: padding,
          foregroundDecoration: foregroundDecoration,
          decoration: BoxDecoration(
            color: color ??
                (gradient == null ? Theme.of(context).cardColor : null),
            gradient: gradient,
            borderRadius: borderRadius ?? BorderRadius.circular(radius),
            border: border,
            boxShadow: boxShadow,
          ),
          child: correctWidget(),
        ),
      ),
    );
  }

  Function()? get onTapButton => (onHover != null && onTap == null)
      ? () {}
      : isDisable
          ? null
          : onTap;
}
