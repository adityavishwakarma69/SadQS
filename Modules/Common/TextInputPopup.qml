import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Modules.Common
import Theme

Overlay {
  id: root
  implicitWidth: Math.max(1, container.width)
  implicitHeight: Math.max(1, container.height)
  color: "transparent"

  required property string placeholder
  property var echoMode: TextInput.Normal
  signal returnValue(value: string)

  property string labelText: ""
  Rectangle {
    id: container
    color: Colors.cSurface
    border.width: Metrics.textInputPopup.borderWidth
    border.color: Colors.cOutline
    radius: Metrics.textInputPopup.radius
    implicitWidth: cols.width + cols.anchors.margins * 2
    implicitHeight: cols.height + cols.anchors.margins * 2
    ColumnLayout {
      id: cols
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.margins: Metrics.textInputPopup.contentMargin
      spacing: anchors.margins
      StyledText {
        visible: !(root.labelText === "")
        text: root.labelText
        font.pixelSize: Typography.font.size.normal
        Layout.maximumWidth: Metrics.textInputPopup.maxTextWidth
        wrapMode: Text.Wrap
      }
      TextField {
        id: inputField
        focus: root.visible
        echoMode: root.echoMode
        Layout.fillWidth: true
        placeholderText: root.placeholder
        font.pixelSize: Typography.font.size.normal
        color: Colors.cOnSurface
        background: Rectangle {
          color: Colors.cSurfaceContainer
          radius: Metrics.textInputPopup.fieldRadius
        }
        Keys.onEscapePressed: {
          clear()
          root.close()
        }
        Keys.onReturnPressed: {
          root.returnValue(this.text)
          clear()
          root.close()
        }
      }
    }
  }
}
