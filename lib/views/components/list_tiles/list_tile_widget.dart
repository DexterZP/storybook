import 'package:flutter/material.dart';

class PZLListTile extends StatelessWidget {
  final double? height;
  final Function()? onTap;
  final Widget? leading;
  final Widget? child;
  final Widget? trailing;
  final bool isVisible;
  final bool isSelected;
  final Color? colorSelected;
  final Gradient? gradientSelected;
  final double spacing;
  //Default hideLeading is false when isVisibleOption is true
  final bool hideLeading;
  //Default hideChild is true when isVisibleOption is true
  final bool hideChild;
  //Default hideTrailling is true when isVisibleOption is true
  final bool hideTrailing;
  final Border? border;
  final MainAxisAlignment alignment;
  final bool isSelectable;
  final MainAxisSize? mainAxisSize;

  const PZLListTile({
    Key? key,
    this.height,
    this.onTap,
    this.leading,
    this.child,
    this.trailing,
    this.isVisible = true,
    this.isSelected = false,
    this.colorSelected,
    this.gradientSelected,
    this.hideLeading = false,
    this.hideChild = false,
    this.hideTrailing = false,
    this.spacing = 16,
    this.border,
    this.alignment = MainAxisAlignment.start,
    this.isSelectable = false,
    this.mainAxisSize = MainAxisSize.max,
  })  : assert(colorSelected == null || gradientSelected == null),
        super(key: key);

  sized(bool willHide, bool haveWidget) => Container(
      width: !isVisible && willHide
          ? 0
          : haveWidget
              ? spacing
              : 0);
  item(Widget? widget, bool willHide) => widget == null
      ? const SizedBox()
      : willHide
          ? SizedBox(
              width: isVisible ? null : 0,
              child: widget,
            )
          : widget;
  rowItems() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: isVisible ? alignment : MainAxisAlignment.center,
        mainAxisSize: mainAxisSize!,
        children: [
          item(leading, hideLeading),
          sized(hideLeading || hideChild, child != null && leading != null),
          item(child, hideChild),
          sized(hideTrailing, trailing != null && child != null),
          item(trailing, hideTrailing),
        ],
      );
  rowSelectable(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSelected ? 1 : 0,
            child: SizedOverflowBox(
              size: Size.zero,
              child: Container(
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  color: colorSelected ?? (gradientSelected == null ? Theme.of(context).selectedRowColor : null),
                  gradient: isSelected ? gradientSelected : null,
                  borderRadius: BorderRadius.circular(19),
                ),
                height: 40,
                width: 14,
              ),
            ),
          ),
          SizedBox(
            width: isVisible ? 70 : 0,
          ),
          Expanded(child: rowItems()),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(border: border),
        child: isSelectable ? rowSelectable(context) : rowItems(),
      ),
    );
  }
}
