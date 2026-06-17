import QtQuick
import Quickshell.Services.UPower

import Modules.Common
import Theme

StaticWidget {
  paddingX: Metrics.bar.widget.padding.x
  paddingY: Metrics.bar.widget.padding.y
  property UPowerDevice powerDevice: UPower.displayDevice  
  property bool isBattery: powerDevice.isLaptopBattery
  property var powerState: powerDevice.state;

  StyledText {
    property string icon: parent.powerState === UPowerDeviceState.FullyCharged ? " " : parent.powerState === UPowerDeviceState.Charging ? " " : " "
    property color textColor: parent.powerDevice.percentage < 0.3 ? Colors.cError : Colors.cOnSurface
    text: icon + (parent.isBattery ? parent.powerDevice.percentage * 100 + "%" : "")
    color: textColor
  }
}
