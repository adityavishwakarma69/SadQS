pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Modules.Common
import Theme

Row {
  id: root
  leftPadding: Metrics.bar.widget.padding.x
  rightPadding: Metrics.bar.widget.padding.x
  topPadding: Metrics.bar.widget.padding.y
  bottomPadding: Metrics.bar.widget.padding.y 
  spacing: Metrics.bar.widget.innerMargin.x
  visible: SystemTray.items.values.length > 0

  StyledText {
    text: "「"
  }

  Repeater {
    id: repeater
    model: SystemTray.items
    IconImage {
      id: icon
      required property var modelData
      source: modelData.icon
      implicitSize: Metrics.iconSizeSmall
      QsMenuAnchor {
        id: menu
        menu: icon.modelData.menu
        anchor.window: QsWindow.window
      }
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
          if (mouse.button === Qt.RightButton) {
            menu.anchor.rect.x = mapToItem(null, 0, 0).x
            menu.anchor.rect.y = mapToItem(null, 0, 0).y + icon.height
            menu.open()
          }
          else {
            icon.modelData.activate()
          }
        }
      }
    }
  }
StyledText {
    text: "」"
  }
}
