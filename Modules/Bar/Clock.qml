import QtQuick
import Modules.Common
import Quickshell
import Theme

StyledText {
  leftPadding: Metrics.bar.widget.padding.x
  rightPadding: Metrics.bar.widget.padding.x
  topPadding: Metrics.bar.widget.padding.y
  bottomPadding: Metrics.bar.widget.padding.y 
  id: clockText
  text: Qt.formatDateTime(clock.date, "hh:mm AP")
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

