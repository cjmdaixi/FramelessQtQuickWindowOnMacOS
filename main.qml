import QtQuick
import QtQuick.Controls 2.2
import FramelessQuickDemo

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Frameless.enabled: true

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

    Column{
        anchors.centerIn: parent
        spacing: 10
        Button{
            text: "Change Enabled"
            onClicked:{
                window.Frameless.enabled = !window.Frameless.enabled;
            }
        }
        Button{
            text: "Change close button"
            onClicked:{
                window.Frameless.closeButtonVisible = !window.Frameless.closeButtonVisible;
            }
        }
        Button{
            text: "Change min button"
            onClicked:{
                window.Frameless.minButtonVisible = !window.Frameless.minButtonVisible;
            }
        }
        Button{
            text: "Change zoom button"
            onClicked:{
                window.Frameless.maxButtonVisible = !window.Frameless.maxButtonVisible;
            }
        }
    }


}
