//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick
import "Modules/Bar"
import "Modules/Launcher"
import "Modules/Menu"
import "Modules/Common"

ShellRoot{
  Bar{}
  Launcher{
    id: launcher
  }
  /*WifiMenu{
    id: wifiMenu
  }
  */
  IpcHandler{
    target: "launcher"
    function toggle():void{
      launcher.toggle()
    }
  }
  /*IpcHandler{
    target: "wifiMenu"
    function toggle():void{
      wifiMenu.toggle()
    }
  }
  */
}
