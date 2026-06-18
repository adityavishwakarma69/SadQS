pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Modules.Common
import Theme

StaticWidget {
    id: root
    required property var window
    RowLayout {
        Repeater {
            model: SystemTray.items
            delegate: RowLayout {
                id: row
                required property var modelData

                IconImage {
                    id: icon
                    source: parent.modelData.icon
                    implicitSize: Metrics.iconSizeSmall
                    mipmap: true
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.RightButton) {
                                if (row.modelData.hasMenu)
                                menuAnchor.anchor.rect.x = mouse.x + mapToItem(null, 0, 0).x
                                menuAnchor.anchor.rect.y = mouse.y + mapToItem(null, 0, 0).y
                                    menuAnchor.open();
                            } else {
                                row.modelData.activate();
                            }
                        }
                    }
                }

                QsMenuAnchor {
                    id: menuAnchor
                    menu: row.modelData.menu
                    anchor.window: root.window
                }
            }
        }
    }
}
