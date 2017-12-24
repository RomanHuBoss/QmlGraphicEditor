/*
  QML-template of buttons panel
  Author: Rabinovich R.M.
  You can use & modificate the following code without any restrictions
  Date: 10.11.2017
*/

import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

Flickable {

    width: 202
    height: parent.height
    contentHeight: parent.height
    clip: true

    anchors {
        left: parent.left
        top: parent.top
        bottom:parent.bottom
    }

    LinearGradient {
      anchors.fill: parent
      start: Qt.point(0, 0)
      end: Qt.point(800, 0)
      gradient: Gradient {
          GradientStop { position: 0.1; color: "#666666" }
          GradientStop { position: 1.0; color: "#CCCCCC" }
      }
    }

    ScrollView {
        anchors.fill: parent
        //verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn

        //в 2 столбца разместим кнопки
        GridLayout {
            anchors.fill: parent
            id: generalButtonsWrapper
            columns: 2
            columnSpacing: 1
            rowSpacing: 1

            GeneralButton {
                id: settingsBtn
                btnText: "Настройки"
                btnImage: "qrc:/36px/settings.png"
                btnAlt: "Настройка приложения"
            }

            GeneralButton {
                id: saveBtn
                btnText: "Сохранить"
                btnImage: "qrc:/36px/file-save.png"
                btnAlt: "Сохранить данные сцены в файл"
            }


            GeneralButton {
                id: createFileBtn
                btnText: "Создать"
                btnImage: "qrc:/36px/file-create.png"
                btnAlt: "Создать новую сцену"
            }

            GeneralButton {
                id: openFileBtn
                btnText: "Загрузить"
                btnImage: "qrc:/36px/file-open.png"
                btnAlt: "Загрузить сцену из файла"
            }

            GeneralButton {
                id: undoBtn
                btnText: "Отменить"
                btnImage: "qrc:/36px/undo.png"
                btnAlt: "Отмена последнего изменения"
            }

            GeneralButton {
                id: redoBtn
                btnText: "Повторить"
                btnImage: "qrc:/36px/redo.png"
                btnAlt: "Повторить отмененное изменение"
            }

            GeneralButton {
                id: cleanupBtn
                btnText: "Очистить"
                btnImage: "qrc:/36px/cleanup.png"
                btnAlt: "Очистить сцену"
            }

            GeneralButton {
                id: eraserBtn
                btnText: "Удалить"
                btnImage: "qrc:/36px/erase.png"
                btnAlt: "Удалить объект"
            }

            GeneralButton {
                id: rotateBtn
                btnText: "Повернуть"
                btnImage: "qrc:/36px/rotate.png"
                btnAlt: "Повернуть объект"
            }

            GeneralButton {
                id: resizeBtn
                btnText: "Размер"
                btnImage: "qrc:/36px/resize.png"
                btnAlt: "Изменить размер объекта"
            }

            GeneralButton {
                id: createLineBtn
                btnText: "Линия"
                btnImage: "qrc:/36px/add-line.png"
                btnAlt: "Нарисовать линию"
            }

            GeneralButton {
                id: createMultilineBtn
                btnText: "Ломаная"
                btnImage: "qrc:/36px/add-multiline.png"
                btnAlt: "Нарисовать ломаную"
            }

            GeneralButton {
                id: createTriangleBtn
                btnText: "Треугольник"
                btnImage: "qrc:/36px/add-triangle.png"
                btnAlt: "Нарисовать треугольник"
            }

            GeneralButton {
                id: createSquareBtn
                btnText: "Квадрат"
                btnImage: "qrc:/36px/add-square.png"
                btnAlt: "Нарисовать квадрат"
            }


            GeneralButton {
                id: createRectangleBtn
                btnText: "Прямоугольник"
                btnImage: "qrc:/36px/add-rectangle.png"
                btnAlt: "Нарисовать прямоугольник"
            }

            GeneralButton {
                id: createPolygonBtn
                btnText: "Полигон"
                btnImage: "qrc:/36px/add-polygon.png"
                btnAlt: "Нарисовать полигон"
            }

            GeneralButton {
                id: createTextBtn
                btnText: "Надпись"
                btnImage: "qrc:/36px/add-text.png"
                btnAlt: "Добавить надпись"
            }

            GeneralButton {
                id: createFillBtn
                btnText: "Заливка"
                btnImage: "qrc:/36px/fill-color.png"
                btnAlt: "Закрасить объект"
            }
        }

    }
}
