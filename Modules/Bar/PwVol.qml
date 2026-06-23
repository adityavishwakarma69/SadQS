import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import Modules.Common
import Quickshell.Services.Pipewire
import Theme

Item {
  id: root
  implicitHeight: content.height
  implicitWidth: content.width

  PwObjectTracker{
    objects: [Pipewire.defaultAudioSink]
  }
  property var sink: Pipewire.defaultAudioSink
  property bool muted: sink ? sink.audio.muted : false
  property real volume: sink ? sink.audio.volume : 0
  Row {
    id: content
    leftPadding: Metrics.bar.widget.padding.x
    rightPadding: Metrics.bar.widget.padding.x
    topPadding: Metrics.bar.widget.padding.y
    bottomPadding: Metrics.bar.widget.padding.y 

    spacing: Metrics.bar.widget.innerMargin.x

    IconImage {
      source: {
        if (root.muted) return "image://icon/audio-volume-muted"
        if (root.volume <= 0.2) return "image://icon/audio-volume-low"
        if (root.volume <= 0.5) return "image://icon/audio-volume-medium"
        if (root.volume <= 1) return "image://icon/audio-volume-high"
      }
      implicitSize: Metrics.iconSizeSmall
      MultiEffect {
        anchors.fill: parent
        source: parent
        colorization: 1
        colorizationColor: root.muted ? Colors.cError : Colors.cOnSurface
      }
    }

    StyledText {
      text: Math.round(root.volume * 100) + "%"
      color: root.muted ? Colors.cError : Colors.cOnSurface
    }
  }
  MouseArea {
    anchors.fill: parent
    onWheel: (wheel) => {
      const step = (wheel.angleDelta.y > 0 ? 0.01 : -0.01)
      root.sink.audio.volume = root.volume + step
    }
    onClicked: {
      root.sink.audio.muted = !root.sink.audio.muted 
    }
  }
}
