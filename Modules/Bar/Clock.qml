import QtQuick
import Quickshell
import Theme
import Modules.Common

StaticWidget {
  paddingX: Metrics.bar.widget.padding.x
  paddingY: Metrics.bar.widget.padding.y
  property string currTime: ""

  StyledText {
    id: clockText
    text: Qt.formatDateTime(clock.date, "hh:mm AP")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
