pragma Singleton

import QtQuick

QtObject {
  readonly property QtObject font : QtObject {
    readonly property string family: "JetBrainsMono Nerd Font"

    readonly property QtObject size: QtObject {
      readonly property int small: 10
      readonly property int normal: 12
      readonly property int large: 15
    }
    readonly property QtObject weight: QtObject {
        readonly property int normal: Font.Normal
        readonly property int bold: Font.Bold
    }
  }
}
