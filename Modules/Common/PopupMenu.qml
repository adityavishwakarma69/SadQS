// requires an attached PanelWindow to work
import QtQuick
import Quickshell
import Theme

PopupWindow {
  id: root

  // Required: position relative to the parent window
  // required property point position
  required property int popupWidth
  required property int popupHeight

  visible: false
  color: Colors.cSurfaceAlpha
  grabFocus: true

  // anchor.rect.x: position.x
  // anchor.rect.y: position.y
  implicitWidth: popupWidth
  implicitHeight: popupHeight

  function toggle() { root.visible = !root.visible }
  function close()  { root.visible = false }
}
