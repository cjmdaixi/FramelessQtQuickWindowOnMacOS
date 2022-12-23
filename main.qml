import QtQuick
import QtQuick.Controls 2.2
import FramelessQuickDemo

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    FramelessController.enabled: true

    background: Rectangle{
        gradient:Gradient {
            GradientStop { position: 0; color: "firebrick" }
            GradientStop { position: 1; color: "black" }
        }
    }
    Rectangle{

        id: titleBar
        width: parent.width
        height: 30
        color: "transparent"

        DragHandler {
            onActiveChanged: if (active) window.startSystemMove();
            target: null
        }
    }

    Button{
        anchors.centerIn: parent
        text: "Change"
        onClicked:{
            window.FramelessController.enabled = !window.FramelessController.enabled;
        }
    }
}
