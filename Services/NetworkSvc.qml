pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell.Networking

Item {
  id: root
  property string primaryInterface: ""
  property var primaryDevice: Networking.devices.values.find(d => d.name === primaryInterface)

  Process {
    id: dbusMonitor
    running: true
    command: ["dbus-monitor", "--system",
      "type='signal',interface='org.freedesktop.NetworkManager'"]
    stdout: SplitParser {
      onRead: data => delayTimer.restart()
    }
  }

  Timer {
    id: delayTimer
    interval: 5000
    onTriggered: {
        fetchPrimary.running = true
      }
  }

  Process {
    id: fetchPrimary
    running: true  // run once on startup too
    command: ["sh", "-c", "ip route get 1.1.1.1 2>/dev/null | grep -oP 'dev \\K\\S+'"]
    stdout: StdioCollector {
      onStreamFinished: root.primaryInterface = this.text.trim()
    }
  }
}
