// Overlay.qml
import Quickshell
import QtQuick
import Quickshell.Wayland

// Overlay.qml
PanelWindow {
    id: root
    
    visible: false
    //color: ""
    
    implicitHeight: 600
    implicitWidth: 400
    
    margins {
        left: (Screen.width - width) / 2
        top: (Screen.height - height) / 3
    }
    
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    
    Item {
        anchors.fill: parent
        focus: root.visible
        
        Keys.onEscapePressed: root.close()
    }
   
    function open()  { visible = true }
    function close() { visible = false }
    function toggle() { visible = !visible }
}
