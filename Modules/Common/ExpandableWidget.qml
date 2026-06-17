import QtQuick
import QtQuick.Layouts

Widget {
  //default property alias content: inner.data
  required property real collapsedWidth
  required property real expandedWidth
  required property real collapsedHeight
  required property real expandedHeight
  property bool expanded: false

  clip: true
  Layout.preferredWidth: expanded ? expandedWidth : collapsedWidth + paddingX
  Layout.preferredHeight: expanded ? expandedHeight : collapsedHeight + paddingY

  Behavior on Layout.preferredWidth {
    NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
  }
  Behavior on Layout.preferredHeight {
    NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
  }
}
