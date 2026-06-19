pragma Singleton

import QtQuick

QtObject {
  readonly property int radius: 12
  readonly property int spacing: 8
  readonly property int padding: 2

  readonly property int iconSizeSmall: 15

  readonly property QtObject bar: QtObject {
    readonly property int height: 30
    readonly property QtObject padding: QtObject {
      readonly property int left: 7
      readonly property int right: 7
      readonly property int top: 0
      readonly property int bottom: 0
    }
    readonly property QtObject margin: QtObject {
      readonly property int left: 0
      readonly property int right: 0
      readonly property int top: 0
      readonly property int bottom: 0
    }

    readonly property QtObject widget : QtObject {
      readonly property QtObject margin: QtObject {
        readonly property int x: 8
        readonly property int y: 0
      }
      readonly property QtObject padding: QtObject {
        readonly property int x: 4
        readonly property int y: 0
      }
    } 
  }
  readonly property QtObject launcher: QtObject {
    readonly property int width: 300
    readonly property int height: 300
    readonly property QtObject content: QtObject {
      // margin between the items
      readonly property int margin: 5
      // padding top and bottom of the whole list view
      readonly property int padding: 5
      readonly property real radius: 5
    }
    readonly property QtObject field: QtObject {
      readonly property int padding: 5
      readonly property real radius: 5
    }
    readonly property int iconSize: 25
    readonly property real radius: 10
  }
}
