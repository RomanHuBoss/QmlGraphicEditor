import QtQuick 2.9
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog
    visible: true
    sidebarVisible : false
    selectMultiple : false
    selectFolder : false
    selectExisting : (action == "open") ? true : false
    folder : "/"

    property string action

    onAccepted: {
        if (action === "save") {
            appInteractor.onSaveScene(fileDialog.fileUrl);
        }
        else if (action === "open") {
            appInteractor.onSelectSceneFile(fileDialog.fileUrl);
        }
        close();
    }
    onRejected: {
        close();
    }
    nameFilters: ["Scenes (*.json)", "All files (*)"]
}
