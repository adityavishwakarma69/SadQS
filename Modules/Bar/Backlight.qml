import QtQuick
import QtQuick.Layouts
import Theme
import Services
import Modules.Common

ExpandableWidget {
  paddingX: Metrics.bar.widget.padding.x
  paddingY: Metrics.bar.widget.padding.y
  expanded: hoverArea.containsMouse
  collapsedWidth: iconText.width + percentText.width
  expandedWidth: iconText.width + slider.width + percentText.width
  collapsedHeight: parent.height
  expandedHeight: parent.height
  RowLayout {
    spacing: 0
    StyledText {
      id: iconText
      text: "󰃞 "
    }
    Slider { 
      id: slider
      min: 0.1
      visible: hoverArea.containsMouse
      property real fetchedValue: BrightnessSvc.percentage()
      onFetchedValueChanged : {
        value = fetchedValue
      }
      onValueChanged: {
        BrightnessSvc.setAbsBrightness(Math.round(value * BrightnessSvc.maxBrightness))
      }
    }
    StyledText {
      id: percentText
      text: Math.round(BrightnessSvc.percentage() * 100) + "%"
    }
  }

  MouseArea {
    id: hoverArea
    hoverEnabled: true
    anchors.fill: parent 
    onPressed: (mouse) => slider.updateValue(mouse.x - slider.x)
    onPositionChanged: (mouse) => { if (pressed) slider.updateValue(mouse.x - slider.x) }
    onWheel: (event) => {
      const step = Math.round(BrightnessSvc.maxBrightness * 0.01)
      BrightnessSvc.setBrightness(event.angleDelta.y > 0 ? step : -step)
    }
  }
}
