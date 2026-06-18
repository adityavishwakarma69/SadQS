// MenuActions.qml
pragma Singleton
import QtQml

QtObject {
    function runCommand(cmd) {
        let process = Qt.createQmlObject(
            "import Quickshell.Io; Process { }",
            this
        )
        process.command = cmd
        process.running = true
    }
    
    function lockScreen() {
        runCommand(["gtklock"])
    }    
    function shutdown() {
        runCommand(["sh", "-c", "loginctl poweroff"])
    }
    function logout() {
        runCommand(["sh", "-c", "loginctl terminate-user $USER"])
    }
    function restart() {
        runCommand(["sh", "-c", "loginctl reboot"])
    }
    function suspend() {
        runCommand(["sh", "-c", "loginctl suspend"])
    }
}
