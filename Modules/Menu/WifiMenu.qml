pragma ComponentBehavior: Bound
import Modules.Common
import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Services
import Theme

Item {
  id: root
  // all network stuff
  property var wifiDevice: NetworkSvc.primaryDevice?.type === DeviceType.Wifi ? NetworkSvc.primaryDevice : Networking.devices.values.find(d => d.type === DeviceType.Wifi)
  visible: false
  implicitWidth: listRoot.width
  implicitHeight: listRoot.height
  required property int posX;
  required property int posY;
  onVisibleChanged: {
    if (visible) {
        listRoot.visible = true
        focus = true
      if (wifiDevice) {
        root.wifiDevice.scannerEnabled = true
      }
      return
    }
    listRoot.visible = false
    root.wifiDevice.scannerEnabled = false
  }

  Overlay {
    id: listRoot
    implicitWidth: Metrics.wifiMenu.width
    implicitHeight: Metrics.wifiMenu.height
    color: "transparent"
    margins {
      left: root.posX
      top: root.posY
    }
    //color: "red" 

    PopupWindow {
      id: wifiList
      implicitWidth: Math.max(1, listRoot.implicitWidth)
      implicitHeight: Math.max(1, listRoot.implicitHeight)
      anchor.window: listRoot
      color: "transparent"
      visible: listRoot.visible && !passwordDialog.visible
      grabFocus: true

      onVisibleChanged: {
        if (!visible) root.close()
      }

      Rectangle {
        color: Colors.cSurfaceAlpha
        radius: Metrics.wifiMenu.radius
        border.width: Metrics.wifiMenu.borderWidth
        border.color: Colors.cOutline
        anchors.fill: parent
        id: content
        ColumnLayout{
          anchors.margins: Metrics.wifiMenu.contentMargin
          anchors.fill:parent
          spacing: Metrics.wifiMenu.itemSpacing
          Rectangle {
            id: wifiStatus
            property bool wifiEnabled: Networking.wifiEnabled
            color: wifiEnabled ? Colors.cPrimary : Colors.cError
            property color tcolor: wifiEnabled ? Colors.cOnPrimary : Colors.cOnError
            Layout.preferredHeight: childrenRect.height
            Layout.fillWidth: true
            StyledText {
              anchors.left: parent.left
              text: root.wifiDevice? "Wifi" : ""
              color: wifiStatus.tcolor
              anchors.margins: 5
            }
            StyledText {
              anchors.right: parent.right
              anchors.margins: 5
              text: Networking.wifiEnabled ? "Enabled" : "Disabled"
              color: wifiStatus.tcolor
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                Networking.wifiEnabled = !Networking.wifiEnabled
              }
            }
          }
          ListView {
            id: listView
            model: root.wifiDevice?.networks.values ?? []
            //anchors.fill: parent
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: Metrics.wifiMenu.itemSpacing
            clip: true
            delegate: Rectangle {
              color: modelData.connected ? Colors.cPrimary: (hoverArea.containsMouse ? Colors.cSecondary : Colors.cSurface)
              property color tcolor: modelData.connected ? Colors.cOnPrimary: (hoverArea.containsMouse ? Colors.cOnSecondary : Colors.cOnSurface)
              id: delegateItem 
              //implicitWidth: childrenRect.width
              implicitHeight: childrenRect.height
              implicitWidth: ListView.view.width
              required property var modelData
              required property int index
              property bool selected: hoverArea.containsMouse
              StyledText{
                id: text
                anchors.left: parent.left
                anchors.margins: 5
                text: delegateItem.modelData.name?? ""
                width: parent.width
                elide: Text.ElideRight
                color: delegateItem.tcolor
              }
              MouseArea {
                id: hoverArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.connect(delegateItem.modelData)
              }
            }
          }
        }
      } 

    }
  }
  TextInputPopup {
    id: passwordDialog
    property var network;
    echoMode: TextInput.Password
    labelText: "Wifi network" + " '" + (network?.name?? "") + "' " + "requires passkey"
    placeholder: "Passkey for " + (network?.name?? "")
    onReturnValue: (psk) => {
      network?.connectWithPsk(psk)
    }
  }

  function pskreq (network: WifiNetwork): bool{
    return (network.security === WifiSecurityType.WpaPsk || network.security === WifiSecurityType.Wpa2Psk || network.security === WifiSecurityType.Sae) && !(network.known)
  }
  function connect(network: WifiNetwork): void {
    if (pskreq(network)) {
      // Show password dialog
      passwordDialog.network = network
      //listRoot.toggle()
      passwordDialog.open()
    } else if (!network.connected) {
      console.log("connecting to " + network.name)
      network.connect()
      root.close()
    }
  }
  function toggle(): void {root.visible = !root.visible}
  function close(): void {root.visible = false}
}
