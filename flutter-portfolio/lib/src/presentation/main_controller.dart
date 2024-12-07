import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MainController {
  static final _indexStream = StreamController<int>();

  static Stream<int> get indexStream => _indexStream.stream;
  static ItemScrollController scrollController = ItemScrollController();

  static final Map<int, double> indexVisibilityMap = {0: 1};

  static void removeIndexVisibility(index) {
    indexVisibilityMap.removeWhere((k, v) => k == index);
  }

  static void setIndexVisibility(int index, double visibility) {
    indexVisibilityMap[index] = visibility;

    if (indexVisibilityMap.length == 1) {
      _indexStream.sink.add(indexVisibilityMap.keys.toList()[0]);
      return;
    }

    var biggestIndex = -1;

    var fullyVisibleList = indexVisibilityMap.filter((e) => e.value == 1.0);

    if (fullyVisibleList.isNotEmpty) {
      if(fullyVisibleList.containsKey(0)){
        _indexStream.sink.add(0);
        return;
      }
      final d = fullyVisibleList.keys.max();
      if (d != null) {
        biggestIndex = d;
      }
    } else {
      // contains non-fully visible index
      var curKey = -1;
      var curValue = -1.0;
      indexVisibilityMap.forEach((key, value) {
        if (value >= curValue) {
          curKey = key;
          curValue = value;
        }
      });

      if (curKey != -1) {
        biggestIndex = curKey;
      }
    }

    if (biggestIndex == -1) return;

    _indexStream.sink.add(biggestIndex);
  }
}
