// Overlay.qml
import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
    id: root
    
    visible: false
    //color: ""
    
    implicitHeight: 600
    implicitWidth: 400
    anchors {
      top: true
      left: true
    }
    
    margins {
        left: (Screen.width - width) / 2
        top: (Screen.height - height) / 2
    }
    
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive  
   
    function open()  { visible = true }
    function close() { visible = false }
    function toggle() { visible = !visible }
}
