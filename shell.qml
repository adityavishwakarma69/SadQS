//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick
import "Modules/Bar"
import "Modules/Launcher"

ShellRoot{
  Bar{}
  Launcher{
    id: launcher
  }
  IpcHandler{
    target: "launcher"
    function toggle():void{
      launcher.toggle()
    }
  }
}
