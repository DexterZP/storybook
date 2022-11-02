import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../routing/controls.dart';

abstract class Organizer {
  final List<Organizer> organizers;
  final OrganizerType type;
  final String name;
  Organizer? parent;

  /// Abstract class for organizer panel in the left.
  Organizer(this.name, this.type, this.organizers);
}

enum OrganizerType { category, component, folder }

class Category extends Organizer {
  final String categoryName;

  Category({required this.categoryName, required List<Organizer> organizers})
      : super(categoryName, OrganizerType.category, organizers) {
    for (final Organizer organizer in organizers) {
      organizer.parent = this;
    }
  }
}

class Folder extends Organizer {
  final String folderName;

  Folder({required this.folderName, required List<Organizer> organizers})
      : super(folderName, OrganizerType.folder, organizers) {
    for (final Organizer organizer in organizers) {
      organizer.parent = this;
    }
  }
}

class Component extends Organizer {
  final String componentName;

  /// Markdown with documentation for the component.
  final List<ComponentState> states;

  Component({
    required this.componentName,
    required this.states,
  }) : super(componentName, OrganizerType.component, const <Organizer>[]) {
    for (final ComponentState state in states) {
      state.parent = this;
    }
  }
}

class ComponentState {
  Component? parent;
  final String stateName;
  final String? codeSample;
  final String? docWeb;
  final Widget Function(BuildContext, ControlsInterface) builder;

  String get path {
    String path = ReCase(stateName).paramCase;
    Organizer? currentParent = parent;
    while (currentParent != null) {
      path = '${ReCase(currentParent.name).paramCase}${'/$path'}';
      currentParent = currentParent.parent;
    }
    return path;
  }

  ComponentState({
    required this.builder,
    required this.stateName,
    this.codeSample,
    this.docWeb,
  });

  factory ComponentState.center({
    required Widget child,
    String? codeSample,
    String? docWeb,
    required String stateName,
  }) =>
      ComponentState(
        builder: (_, __) => Center(child: child),
        stateName: stateName,
        docWeb: docWeb,
        codeSample: codeSample,
      );

  factory ComponentState.child({
    required Widget child,
    String? codeSample,
    String? docWeb,
    required String stateName,
  }) =>
      ComponentState(
        builder: (_, __) => child,
        stateName: stateName,
        docWeb: docWeb,
        codeSample: codeSample,
      );
}

class ListItem<T> {
  final String title;
  final T value;
  ListItem({
    required this.title,
    required this.value,
  });
}
