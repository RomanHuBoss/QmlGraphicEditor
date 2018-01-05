import QtQuick 2.9
import QtQuick.Dialogs 1.0

FileDialog {
    id: fileDialog
    visible : false
    title: "Выберите сцену"
    sidebarVisible : false
    folder : "/"
    onAccepted: {
        console.log("You chose: " + fileDialog.fileUrls)
        Qt.quit()
    }
    onRejected: {
        Qt.quit()
    }
    nameFilters: [ "Файлы сцен (*.json)"]
}
