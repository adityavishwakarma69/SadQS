import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Theme
import Services
import Modules.Common

StaticWidget {
  paddingX: Metrics.bar.widget.padding.x
  paddingY: Metrics.bar.widget.padding.y
  RowLayout {
    spacing: parent.marginXHint
    Repeater {
      model: NiriSvc.workspaces
      StyledText{
        // don't show the last workspace (extra niri reserved)
        property color tcol: (model.isFocused ? Colors.cPrimary : Colors.cOnSurface)
        visible: model.index < NiriSvc.workspaces.count
        text: model.index
        color: tcol
        MouseArea {
          id: hoverArea
          hoverEnabled: true
          anchors.fill: parent
          onClicked: 
            if (!model.isFocused)
              NiriSvc.focusWorkspace(model.index)
        }
      }
    }

    IconImage {
      property string srcPath: NiriSvc.focusedWindow?.iconPath ?? ""
      source: srcPath != ""? "file://" + srcPath : ""
      implicitSize: Metrics.iconSizeSmall
      mipmap: true
      visible: srcPath != ""
    }

    StyledText {
      // trim the text
      elide: Text.ElideRight
      Layout.maximumWidth: 200
      // if NiriSvc.focusedWindow exists and has text
      text: NiriSvc.focusedWindow?.title ?? ""
    }
  }
}
