import QtQuick
import Quickshell.Io

pragma Singleton

Item {
  id: root
  property int brightness: 0
  property int maxBrightness: 100

  Process {
    id: fetchBrightness
    running: true
    command: ["brightnessctl", "g"]
    stdout: StdioCollector {
      onStreamFinished: root.brightness = parseInt(this.text)
    }
  }

  Process {
    id: fetchMax
    running: true
    command: ["brightnessctl", "m"]
    stdout: StdioCollector {
      onStreamFinished: root.maxBrightness = parseInt(this.text)
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: fetchBrightness.running = true
  }

  function percentage(): real {
    return brightness / maxBrightness
  }
  Process {
    id: setProc
  }

  function setBrightness(delta: int): void {
    const newVal = Math.max(0, Math.min(maxBrightness, brightness + delta))
    setProc.command = ["brightnessctl", "s", String(newVal)]
    setProc.running = true
    brightness = newVal
  }

  function setAbsBrightness(val: int): void {
    const newVal = Math.max(0, Math.min(maxBrightness, val))
    setProc.command = ["brightnessctl", "s", String(newVal)]
    setProc.running = true
    brightness = newVal
  }
}
