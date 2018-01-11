import QtQuick 2.2
import QtQuick.Dialogs 1.0

ColorDialog {
    id: colorDialog
    title: "Цвет заливки замкнутых фигур"
    modality : Qt.WindowModal

    onAccepted: {
        scene.fillColor = colorDialog.color;
    }
    onRejected: {
        close();
    }

    Component.onCompleted: visible = true
}
