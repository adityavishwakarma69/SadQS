pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Modules.Common
import Theme

StaticWidget {
  id: root
  property bool menuOpen: true
  required property var rootWindow
  RowLayout {
    StyledText {
      id: textTest
      text: "⭘"
      MouseArea {
        anchors.fill: parent
        onClicked: {
          menu.anchor.rect.x = textTest.mapToItem(null, 0, 0).x;
          menu.anchor.rect.y = Window.window.y + Window.window.height;
          menu.toggle();
        }
      }
    }
  }

  PopupMenu {
    id: menu
    anchor.window: root.rootWindow
    popupWidth: content.implicitWidth
    popupHeight: content.implicitHeight
    color: "transparent"

    Rectangle {
      id: content
      implicitWidth: col.implicitWidth
      implicitHeight: col.implicitHeight
      color: Colors.cSurfaceAlpha
      opacity: menu.visible ? 1 : 0
      // hardcoded bullshit
      y: menu.visible ? 0 : -30

      Behavior on opacity {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
      }
      Behavior on y {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
      }

      ColumnLayout {
        id: col
        spacing: 0
        ButtonLabel {
          label: ""
          onTriggered: {
            menu.close();
            PowerMenuActions.shutdown();
          }
          Layout.fillWidth: true
          fontSize: Typography.font.size.huge
        }
        ButtonLabel {
          label: "󰍃"
          onTriggered: {
            menu.close();
            PowerMenuActions.logout();
          }
          Layout.fillWidth: true
          fontSize: Typography.font.size.huge
        }
        ButtonLabel {
          label: ""
          onTriggered: {
            menu.close();
            PowerMenuActions.lockScreen();
          }
          Layout.fillWidth: true
          fontSize: Typography.font.size.huge
        }
        ButtonLabel {
          label: "󰏦"
          onTriggered: {
            menu.close();
            PowerMenuActions.suspend();
          }
          Layout.fillWidth: true
          fontSize: Typography.font.size.huge
        }
        ButtonLabel {
          label: ""
          onTriggered: {
            menu.close();
            PowerMenuActions.restart();
          }
          Layout.fillWidth: true
          fontSize: Typography.font.size.huge
        }
      }
    }
  }
}
