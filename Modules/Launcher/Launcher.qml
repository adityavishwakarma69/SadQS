pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Theme
import Modules.Common

Overlay {
  id: root
  color: "transparent"
  implicitWidth: Metrics.launcher.width
  implicitHeight: Metrics.launcher.height

  property int contentPadding: Metrics.launcher.content.padding
  property int contentSpacing: Metrics.launcher.content.margin
  property int iconSize: Metrics.launcher.iconSize
  property var apps: DesktopEntries.applications
  onVisibleChanged: {
    Qt.callLater(() => searchInput.forceActiveFocus())
  }
  Rectangle {
    id: content
    anchors.fill: parent
    color: Colors.cSurfaceAlpha
    opacity: root.visible ? 1 : 0
    scale: root.visible ? 1 : 0.95
    border.width: 1.5
    border.color: Colors.cOutline
    radius: Metrics.launcher.radius
    
    Behavior on opacity {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
    }
    Behavior on scale {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: root.contentPadding
      spacing: root.contentSpacing

      // Search input
      TextField {
        id: searchInput
        placeholderText: "Search applications..."
        Layout.fillWidth: true
        bottomPadding: Metrics.launcher.field.padding
        topPadding: Metrics.launcher.field.padding
        font.pixelSize: Typography.font.size.large
        color: Colors.cPrimary
        background: Rectangle {
          color: "transparent"
          border.width: 1
          border.color: Colors.cPrimary
          radius: Metrics.launcher.field.radius
        }
        // start with first
        property int index: 0
        property var filteredApps: {
          let apps = root.apps.values;
          let search = searchInput.text.toLowerCase();
          let filtered = apps.filter(app => app.name.toLowerCase().includes(search) || (app.comment && app.comment.toLowerCase().includes(search)));
          return filtered.sort((a, b) => a.name.localeCompare(b.name));
        }
        onFilteredAppsChanged:{
          index = 0
        }
        Keys.onUpPressed: {
          let newIndex = index - 1;
          if (newIndex >= 0) {
            index = newIndex;
          }
        }
        Keys.onDownPressed: {
          let newIndex = index + 1;
          if (newIndex < filteredApps.length) {
            index = newIndex;
          }
        }
        Keys.onEscapePressed: {
          root.close();  // close the Overlay
        }
        Keys.onReturnPressed: {
          root.close();
          // if nothing selected during execution selected first
          filteredApps[index]?.execute();
          index = 0
          clear()
        }
      }

      // App list
      ScrollView {
        id: scrollView
        Layout.fillWidth: true
        Layout.fillHeight: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        topPadding: Metrics.launcher.content.padding
        bottomPadding: Metrics.launcher.content.padding
        ListView {
          model: searchInput.filteredApps
          spacing: Metrics.launcher.content.margin
          clip: true

          delegate: Rectangle {
            id: delegate
            required property var modelData
            required property int index
            property bool selected: index === searchInput.index
            width: ListView.view.width
            height: childrenRect.height
            color: mouseArea.containsMouse || selected ? Colors.cPrimary : "transparent"
            radius: Metrics.launcher.content.radius

            onSelectedChanged: {
              if (selected) {
                ListView.view.positionViewAtIndex(index, ListView.Contain);
              }
            }

            RowLayout {
              Layout.fillWidth: true
              spacing: Metrics.launcher.content.margin
              Layout.preferredHeight: childrenRect.height
              Layout.preferredWidth: childrenRect.width
              IconImage {
                source: delegate.modelData.icon ? "image://icon/" + delegate.modelData.icon : "image://icon/application-x-executable"
                implicitSize: Metrics.launcher.iconSize
                mipmap: true
                onStatusChanged: {
                  if (status === Image.Error) {
                    source = "image://icon/application-x-executable";
                  }
                }
              }
              StyledText {
                text: delegate.modelData.name
                font.pixelSize: Typography.font.size.large
                color: mouseArea.containsMouse || delegate.selected ? Colors.cOnPrimary : Colors.cOnSurface
              }
            }
            MouseArea {
              id: mouseArea
              anchors.fill: parent
              hoverEnabled: true
              onClicked: {
                root.close();
                delegate.modelData.execute();
                searchInput.index = 0
                searchInput.clear()
              }
            }
          }
        }
      }
    }
  }
}
