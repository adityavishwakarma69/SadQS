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

  Rectangle {
    id: root
    anchors.fill: parent
    // bar padding
    anchors.leftMargin: Metrics.bar.padding.left
    anchors.rightMargin: Metrics.bar.padding.right
    anchors.topMargin: Metrics.bar.padding.top
    anchors.bottomMargin: Metrics.bar.padding.bottom

    color: "transparent"

    // left widgets
    Row {
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      // widgets
      WorkspacesNiri{}
      WindowNiri{}
    }

    // center widgets
    Row {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
      // widgets
      Clock{}
    }

    // right widgets
    Row {
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      // widgets
      SysTray{}
      Network{}
      PwVol{}
      Backlight{}
      Battery{}
    }
    
  }
  anchors.top: true
  anchors.right: true
  anchors.left: true
  implicitHeight: Metrics.bar.height
  color: Colors.cSurfaceAlpha
}
