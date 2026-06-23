import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import Modules.Common
import Services
import Theme


Item {
  id: root
  implicitWidth: content.width
  implicitHeight: content.height
  property int miniumBrightness: 10
  Row {
    id: content
    leftPadding: Metrics.bar.widget.padding.x
    rightPadding: Metrics.bar.widget.padding.x
    topPadding: Metrics.bar.widget.padding.y
    bottomPadding: Metrics.bar.widget.padding.y 

    property int percent: ((BrightnessSvc.brightness / BrightnessSvc.maxBrightness) * 100).toFixed(0)

    spacing: Metrics.bar.widget.innerMargin.x

    IconImage {
      source: {
        if (parent.percent <= 10) return "image://icon/display-brightness-off-symbolic"
        if (parent.percent <= 30) return "image://icon/display-brightness-low-symbolic"
        if (parent.percent <= 60) return "image://icon/display-brightness-medium-symbolic"
        if (parent.percent <= 100) return "image://icon/display-brightness-high-symbolic"
      }
      implicitSize: Metrics.iconSizeSmall

      MultiEffect {
        anchors.fill: parent
        source: parent
        colorization: 1
        colorizationColor: Colors.cOnSurface
      }
    }

    StyledText {
      text: parent.percent + "%"
    }
  }
  MouseArea {
    anchors.fill: parent
    onWheel: (event) => {
      const step = Math.round(BrightnessSvc.maxBrightness * 0.01) * (event.angleDelta.y > 0 ? 1 : -1)
      const newBrightness = (BrightnessSvc.brightness + step) * 100 / BrightnessSvc.maxBrightness
      if (newBrightness.toFixed(0) >= root.miniumBrightness) BrightnessSvc.setBrightness(step)
    }
  }
}
