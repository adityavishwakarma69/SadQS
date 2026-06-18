// ButtonLabel.qml
pragma ComponentBehavior: Bound
import QtQuick
import Modules.Common
import Theme

Rectangle {
  id: root

  required property string label
  property int fontSize: Typography.font.size.small
  signal triggered()
  property bool hover: mouseArea.containsMouse

  implicitWidth: text.implicitWidth * 2 + Metrics.padding * 2
  implicitHeight: text.implicitHeight + Metrics.padding * 2

  color: hover ? Colors.cPrimary : "transparent"
  radius: 4

  Behavior on color {
    ColorAnimation { duration: 100 }
  }

  StyledText {
    id: text
    color: root.hover ? Colors.cOnPrimary : Colors.cOnSurface
    text: root.label
    font.pixelSize: root.fontSize
    anchors.centerIn: parent
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: root.triggered()
  }
}
