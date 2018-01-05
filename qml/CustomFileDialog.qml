import QtQuick 2.9
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog
    visible : false
    title: "Выберите сцену"
    sidebarVisible : false
    selectMultiple : false
    selectFolder : false
    selectExisting : true
    folder : "/"

    onAccepted: {
        fileDialog.close()
        appInteractor.onSelectSceneFile(fileDialog.fileUrl);
    }
    onRejected: {
        fileDialog.close()
    }
    nameFilters: [ "Файлы сцен (*.json)"]
}
