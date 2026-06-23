import QtQuick
import Modules.Common
import Services
import Theme

Row {
  leftPadding: Metrics.bar.widget.padding.x
  rightPadding: Metrics.bar.widget.padding.x
  topPadding: Metrics.bar.widget.padding.y
  bottomPadding: Metrics.bar.widget.padding.y
  Repeater {
    model: NiriSvc.workspaces
    StyledText {
      id: delegateRoot
      required property var model
      text: model.index
      visible: model.index < NiriSvc.workspaces.count
      color: model.isFocused ? Colors.cPrimary : Colors.cOnSurface
      font.pixelSize: Typography.font.size.normal
      leftPadding: Metrics.bar.widget.innerMargin.x 
      rightPadding: Metrics.bar.widget.innerMargin.x 
      horizontalAlignment: Text.AlignHCenter

      MouseArea {
        anchors.fill: parent
        onClicked: NiriSvc.focusWorkspaceById(delegateRoot.model.id)
      }
    }
  }
}
