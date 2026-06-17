import Quickshell
import QtQuick
import QtQuick.Layouts
import Theme

PanelWindow {

  // bar margin
  margins {
    right: Metrics.bar.margin.right
    left: Metrics.bar.margin.left
    top: Metrics.bar.margin.top
    bottom: Metrics.bar.margin.bottom
  }

  id: bar

  Item {
    id: root
    anchors.fill: parent
    // bar padding
    anchors.leftMargin: Metrics.bar.padding.left
    anchors.rightMargin: Metrics.bar.padding.right
    anchors.topMargin: Metrics.bar.padding.top
    anchors.bottomMargin: Metrics.bar.padding.bottom

    property int margin: Metrics.bar.widget.margin.x
    RowLayout {
      id: leftWidgets
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      spacing: root.margin

      // widgets here
      WorkspacesNiri{}
    }
    RowLayout {
      id: centerWidgets
      anchors.centerIn: parent
      spacing: root.margin

      // widgets here
      Clock{}
    }
    RowLayout {
      id: rightWidgets
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
      layoutDirection: Qt.RightToLeft
      spacing: root.margin

      // widgets here
      Battery{}
      Backlight{}
      PwVol{}
      Network{}
      SysTray{window:bar}
    }
  }
  anchors.top: true
  anchors.right: true
  anchors.left: true
  implicitHeight: Metrics.bar.height
  color: Colors.cSurfaceAlpha
}
