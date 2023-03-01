import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../styled_widgets/highlighter.dart';
import '../../utils/utils.dart';
import '../models/organizers.dart';

//ignore_for_file: must_call_super

const Color generalColor = Colors.orange;

class ComponentStateTile extends StatefulWidget {
  const ComponentStateTile({
    Key? key,
    required this.item,
    required this.padding,
    required this.onSelected,
    this.isSelected = false,
  }) : super(key: key);

  final void Function(ComponentState) onSelected;
  final ComponentState item;
  final double padding;
  final bool isSelected;

  @override
  ComponentStateTileState createState() => ComponentStateTileState();
}

class ComponentStateTileState extends State<ComponentStateTile>
    with AutomaticKeepAliveClientMixin {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor = widget.isSelected || hover
        ? context.colorScheme.onPrimary
        : context.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        left: 40,
        right: 12,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Highlighter(
          onEnter: (_) => setState(() => hover = true),
          onExit: (_) => setState(() => hover = false),
          overrideHover: widget.isSelected,
          onPressed: () => widget.onSelected(widget.item),
          color: generalColor,
          child: Container(
            padding: EdgeInsets.fromLTRB(widget.padding, 4, 0, 4),
            decoration: BoxDecoration(
              color: hover || widget.isSelected
                  ? generalColor
                  : const Color(0xff26292E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  FeatherIcons.bookmark,
                  size: 14,
                  color: widget.isSelected || hover
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.item.stateName,
                  style:
                      context.textTheme.bodyLarge!.copyWith(color: hoverColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ComponentTile extends StatefulWidget {
  const ComponentTile({
    Key? key,
    required this.states,
    required this.padding,
    required this.item,
  }) : super(key: key);

  final List<Widget> states;
  final Organizer item;
  final double padding;

  @override
  ComponentTileState createState() => ComponentTileState();
}

class ComponentTileState extends State<ComponentTile>
    with AutomaticKeepAliveClientMixin {
  bool expanded = false;
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor =
        hover ? context.colorScheme.onPrimary : context.colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 6,
            left: 12,
            right: 12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Highlighter(
              onEnter: (_) => setState(() => hover = true),
              onExit: (_) => setState(() => hover = false),
              onPressed: () => setState(() => expanded = !expanded),
              cursor: (widget.states.isNotEmpty)
                  ? null
                  : SystemMouseCursors.forbidden,
              color: generalColor,
              child: Container(
                padding: EdgeInsets.fromLTRB(widget.padding, 4, 0, 4),
                decoration: BoxDecoration(
                  color: hover ? generalColor : const Color(0xff26292E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (widget.states.isNotEmpty)
                      Icon(FeatherIcons.chevronDown,
                          size: 12, color: hoverColor)
                    else
                      const SizedBox(width: 12),
                    const SizedBox(width: 4),
                    Icon(
                      FeatherIcons.book,
                      size: 14,
                      color:
                          hover ? context.colorScheme.onPrimary : Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.item.name,
                      style: context.textTheme.bodyLarge!
                          .copyWith(color: hoverColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: expanded ? Column(children: widget.states) : Container(),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FolderTile extends StatefulWidget {
  const FolderTile({
    Key? key,
    required this.organizers,
    required this.padding,
    required this.item,
  }) : super(key: key);

  final List<Widget> organizers;
  final Organizer item;
  final double padding;

  @override
  FolderTileState createState() => FolderTileState();
}

class FolderTileState extends State<FolderTile>
    with AutomaticKeepAliveClientMixin {
  bool expanded = false;
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor =
        hover ? context.colorScheme.onPrimary : context.colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Highlighter(
              onEnter: (_) => setState(() => hover = true),
              onExit: (_) => setState(() => hover = false),
              onPressed: () => setState(() => expanded = !expanded),
              color: generalColor,
              cursor: (widget.organizers.isNotEmpty)
                  ? null
                  : SystemMouseCursors.forbidden,
              child: Container(
                padding: EdgeInsets.fromLTRB(widget.padding, 4, 0, 4),
                decoration: BoxDecoration(
                  color: hover ? generalColor : const Color(0xff26292E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (widget.organizers.isNotEmpty)
                      Icon(FeatherIcons.chevronDown,
                          size: 12, color: hoverColor)
                    else
                      const SizedBox(width: 12),
                    const SizedBox(width: 4),
                    Icon(
                      FeatherIcons.archive,
                      size: 14,
                      color:
                          hover ? context.colorScheme.onPrimary : generalColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.item.name,
                      style: context.textTheme.bodyLarge!
                          .copyWith(color: hoverColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: expanded ? Column(children: widget.organizers) : Container(),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
