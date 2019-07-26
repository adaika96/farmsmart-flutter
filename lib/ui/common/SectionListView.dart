

import 'package:flutter/material.dart';

abstract class ListViewSection {
    IndexedWidgetBuilder itemBuilder();
    int length();
}

class _SectionPosition {
  final int offset;
  final ListViewSection section;

  _SectionPosition(this.offset, this.section);
  int relativeOffset(int absoluteOffset) {
      return absoluteOffset - offset;
  }
}

class SectionedListView extends StatelessWidget implements ListViewSection {
  final ScrollPhysics _physics;
  final bool _shrinkWrap;
  final List<_SectionPosition> _sectionPositions;
  final int _allItemCount;

  SectionedListView._(this._sectionPositions,this._allItemCount, this._shrinkWrap, this._physics);

  factory SectionedListView({@required List<ListViewSection> sections, ScrollPhysics physics = const ScrollPhysics(), bool shrinkWrap = true}) {
    int allItemCount = 0;
    final sectionPositions = sections.map((section) {
        int offset = allItemCount;
        allItemCount += section.length();
        return _SectionPosition(offset, section);
    }).toList();
    return  SectionedListView._(sectionPositions,allItemCount,shrinkWrap,physics);
  }

  _SectionPosition sectionForIndex(int index) {
    return _sectionPositions.reversed.firstWhere((
        sectionPosition) => sectionPosition.relativeOffset(index) >= 0,
        orElse: () => null);
  }

  @override
  IndexedWidgetBuilder itemBuilder() {
    return (context, index) {
        final sectionPosition = sectionForIndex(index);
        final sectionBuilder = sectionPosition.section.itemBuilder(); 
        return sectionBuilder(context, sectionPosition.relativeOffset(index));
    };
  }

  @override
  int length() {
    return _allItemCount;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: _physics,
      shrinkWrap: _shrinkWrap,
      itemCount: length(),
      itemBuilder: itemBuilder(),
    );
  }

}