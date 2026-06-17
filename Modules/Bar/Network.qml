import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import Theme
import Services
import Modules.Common

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
        Repeater {
            id: netText
            model: hoverArea.containsMouse ? (root.primaryDevice?.networks.values ?? []) : []
            StyledText {
                required property var model
                text: model?.name ?? ""
            }
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
    }
}
