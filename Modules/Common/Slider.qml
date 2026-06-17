import QtQuick
import Theme

Item {
  id: root
  property real value: 0
  property real min: 0
  property real max: 1
  property color activeColor: Colors.cPrimary
  property color inactiveColor: Colors.cSurfaceVariant

  implicitWidth: 60
  implicitHeight: 4

  Rectangle {
    id: track
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width
    height: parent.height
    radius: height / 2
    color: root.inactiveColor

    Rectangle {
      id: fill
      width: (root.value - root.min) / (root.max - root.min) * track.width
      height: parent.height
      radius: height / 2
      color: root.activeColor
    }
  }

  function updateValue(x: real) {
    const clamped = Math.max(0, Math.min(track.width, x))
    const newVal = root.min + (clamped / track.width) * (root.max - root.min)
    root.value = newVal
    root.valueChanged()
  }
  function updateValudeDelta(dx: real) {
    const clamped = Math.max(0, Math.min(track.width, root.value + dx))
    const newVal = root.min + (clamped / track.width) * (root.max - root.min)
    root.value = newVal
    root.valueChanged() 
  }
}
