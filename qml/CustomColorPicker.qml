import QtQuick 2.2
import QtQuick.Dialogs 1.0

ColorDialog {
    id: colorDialog
    title: "Цвет заливки замкнутых фигур"

    onAccepted: {
        scene.fillColor = colorDialog.color;
    }
    onRejected: {
        close();
    }

    Component.onCompleted: visible = true
}
