import QtQuick
import QtQuick.Layouts
import Theme

Item {
  id: root
  property color bgColorHint: "transparent"
  property int paddingX: Metrics.padding
  property int paddingY: Metrics.padding
  property int marginXHint: Metrics.spacing
  property int marginYHint: Metrics.spacing

  Layout.preferredWidth: childrenRect.width + paddingX
  Layout.preferredHeight: childrenRect.height + paddingY
}
