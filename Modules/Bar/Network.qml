import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import Theme
import Services
import Modules.Common
import Modules.Menu

ExpandableWidget {
  id: root
  paddingX: Metrics.bar.widget.padding.x
  paddingY: Metrics.bar.widget.padding.y
  property var primaryDevice: NetworkSvc?.primaryDevice
  property var deviceType: primaryDevice?.type
  collapsedWidth: iconText.width
  expandedWidth: row.width
  collapsedHeight: parent.height
  expandedHeight: parent.height
  expanded: hoverArea.containsMouse
  RowLayout {
    id: row
    spacing: parent.marginXHint
    StyledText {
      property string conname: root.primaryDevice?.networks.values.find(n => n.connected)?.name ?? ""
      visible: root.expanded
      text: conname
    }
    StyledText {
      id: iconText
      property string deviceText: root.deviceType === DeviceType.Wifi ? " " : (root.deviceType === DeviceType.Wired ? " " : "󰣼 ")
      text: deviceText
      color: root.deviceType ? Colors.cOnSurface : Colors.cError
    }
  }
  MouseArea {
    id: hoverArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: {
      menu.posX = mapToItem(null, 0, 0).x + menu.implicitWidth/2
      menu.toggle()
    }
  }
  WifiMenu{
    id: menu
    posX: 0
    posY: 5
  }
}
