import QtQuick
import QtQuick.Effects
import Quickshell.Networking
import Quickshell.Widgets
import Theme
import Services
import Modules.Menu
import Modules.Common

Item {
  id: root
  implicitHeight: content.height
  implicitWidth: content.width

  property var primaryDevice: NetworkSvc?.primaryDevice
  property var deviceType: primaryDevice?.type
  property var connectedNetwork: root.primaryDevice?.networks?.values.find(n => n.connected)

  Row {
    id: content
    leftPadding: Metrics.bar.widget.padding.x
    rightPadding: Metrics.bar.widget.padding.x
    topPadding: Metrics.bar.widget.padding.y
    bottomPadding: Metrics.bar.widget.padding.y 
    spacing: Metrics.bar.widget.innerMargin.x

    IconImage {
      source : {
        if (root.deviceType === DeviceType.Wifi){
          if (root.connectedNetwork?.signalStrength == 0 ) return "image://icon/network-wireless-signal-none"
          if (root.connectedNetwork?.signalStrength <= 0.3 ) return "image://icon/network-wireless-signal-weak"
          if (root.connectedNetwork?.signalStrength <= 0.6 ) return "image://icon/network-wireless-signal-ok"
          if (root.connectedNetwork?.signalStrength <= 0.8 ) return "image://icon/network-wireless-signal-good"
          if (root.connectedNetwork?.signalStrength <= 1 ) return "image://icon/network-wireless-signal-excellent"
        }
        else if(root.deviceType === DeviceType.Wired) {
          return "image://icon/network-wired"
        }
      }
      implicitSize: Metrics.iconSizeSmall
      MultiEffect {
        anchors.fill: parent
        source: parent
        colorization: 1
        colorizationColor: Colors.cOnSurface
      }
    }

    StyledText{
      text: {
        if (root.deviceType === DeviceType.Wifi) return Math.round((root.connectedNetwork?.signalStrength??0) * 100) + "%"
        if (root.deviceType === DeviceType.Wired) return "ETH"
        return ""
      }
      visible: text !== ""
    }
  }
  WifiMenu{
    id: menu
    posX: 0
    posY: 5
  }
  MouseArea {
    anchors.fill:parent
    onClicked: (mouse) => {
      menu.posX = mapToItem(null, 0, 0).x - menu.width/2 + root.width/2
      menu.toggle()
    }
  }
}
