import QtQuick
import Modules.Common
import Quickshell.Widgets
import Services
import Theme

Row {
  leftPadding: Metrics.bar.widget.padding.x
  rightPadding: Metrics.bar.widget.padding.x
  topPadding: Metrics.bar.widget.padding.y
  bottomPadding: Metrics.bar.widget.padding.y
  spacing: Metrics.bar.widget.innerMargin.x
  IconImage {
    source: NiriSvc.focusedWindow?.iconPath ? "image://icon/" + NiriSvc.focusedWindow.iconPath : ""
    visible: source !== ""
    implicitSize: Metrics.iconSizeSmall

  }
  StyledText {
    text: NiriSvc.focusedWindow?.title?? ""
    width: Math.min(implicitWidth, 300)
    elide: Text.ElideRight
  }
}
