import QtQuick
import QtQuick.Controls 2.2

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Component.onCompleted:{
        WindowEx.handleInit(this);
    }

//    onVisibilityChanged: function(visibility){
//        if (visible)

//        else
//            WindowEx.handleDestroy(this)
//    }

    Rectangle{

        id: titleBar
        width: parent.width
        height: 30
        color: "black"

        DragHandler {
            onActiveChanged: if (active) window.startSystemMove();
            target: null
        }
    }
}
