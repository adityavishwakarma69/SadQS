import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import Theme
import Modules.Common

ExpandableWidget { 
  paddingX: Metrics.bar.widget.padding.x
  paddingY: Metrics.bar.widget.padding.y
  id: volumeWidget
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }
  property var sink: Pipewire.defaultAudioSink
  property bool muted: sink ? sink.audio.muted : false
  property real volume: sink ? sink.audio.volume : 0
  expanded: hoverArea.containsMouse
  collapsedWidth: iconText.width + percentText.width
  expandedWidth: iconText.width + slider.width + percentText.width
  collapsedHeight: parent.height
  expandedHeight: parent.height

  RowLayout{
    spacing: 0
    StyledText {
      id: iconText
      text: (volumeWidget.muted ? "󰝟" : "󰕾") + " "
      color: volumeWidget.muted ? Colors.cError: Colors.cOnSurface
    }
    Slider{
      id: slider
      visible: hoverArea.containsMouse
      value: volumeWidget.volume
    }
    StyledText {
      id: percentText
      text: Math.round(volumeWidget.volume * 100) + "%"
      color: volumeWidget.muted ? Colors.cError: Colors.cOnSurface
    }
  }

  MouseArea {
    id: hoverArea
    hoverEnabled: true
    anchors.fill: parent
    onClicked: (mouse) =>{
      if (volumeWidget.sink && mouse.x < slider.x) volumeWidget.sink.audio.muted = !volumeWidget.sink.audio.muted
    }
    onWheel: (wheel) => {
      if (!volumeWidget.sink) return
      const newVal = Math.max(0, Math.min(1, volumeWidget.volume + (wheel.angleDelta.y > 0 ? 0.01 : -0.01)))
      volumeWidget.sink.audio.volume = newVal
    }
    onPressed: (mouse) => updateVolume(mouse.x)
    onPositionChanged: (mouse) => { if (pressed) updateVolume(mouse.x) }

    function updateVolume(x) {
      const clamped = Math.max(0, Math.min(slider.width, x - slider.x))
      volumeWidget.sink.audio.volume = clamped / slider.width
    }
  }
}
