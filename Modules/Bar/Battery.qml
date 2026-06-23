import QtQuick
import QtQuick.Effects
import Quickshell.Services.UPower
import Quickshell.Widgets
import Modules.Common
import Theme

Row {
  id: root
  leftPadding: Metrics.bar.widget.padding.x
  rightPadding: Metrics.bar.widget.padding.x
  topPadding: Metrics.bar.widget.padding.y
  bottomPadding: Metrics.bar.widget.padding.y 
  property UPowerDevice powerDevice: UPower.displayDevice  
  property bool isBattery: powerDevice.isLaptopBattery
  property var powerState: powerDevice.state;
  spacing: Metrics.bar.widget.innerMargin.x
  IconImage {
    property int batteryLevel: {
      let level = Math.floor(parent.powerDevice.percentage * 10) * 10
      return level.toFixed(0)
    }
    property string iconSuffix: {
      if (parent.powerState === UPowerDeviceState.Charging) return "-charging-symbolic"
      if (parent.powerState === UPowerDeviceState.FullyCharged) return "-charged-symbolic"
      return "-symbolic"  // discharging
    }
    source: "image://icon/battery-level-" + batteryLevel + iconSuffix
    implicitSize: Metrics.iconSizeSmall

    // Color multiplication
    MultiEffect {
      property color effectColor: {
        if (parent.batteryLevel <= 20) return Colors.cError
        if (parent.batteryLevel > 20 && root.powerState === UPowerDeviceState.Charging) return Colors.cError
        return Colors.cOnSurface
      }
      property real effectWeight: {
        if (parent.batteryLevel <= 20) return 1
        return 0.3 
      }
      anchors.fill: parent
      source: parent
      colorization: effectWeight
      colorizationColor: effectColor
    }
  }

  StyledText {
    visible: parent.isBattery
    property color textColor: parent.powerDevice.percentage <= 0.2 ? Colors.cError : Colors.cOnSurface
    text: (parent.isBattery ? (parent.powerDevice.percentage * 100).toFixed(0) + "%" : "")
    color: textColor
  }
}
