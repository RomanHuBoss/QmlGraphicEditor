import QtQuick 2.9

Rectangle {
    id: figure
    color: "transparent"

    /*
    тип фигуры
    LineSegment - отрезок
    Multiline   - ломаная/полигон
    Triangle    - треугольник
    Rectangle   - прямоугольник
    Square      - квадрат
    */
    property string type
    property string uid            //идентификатор фигуры, синхронизированный с хранилищем
    property variant vertices: []  //массив вершин {x,y}
    property bool isClosed         //признак замкнутой фигуры


    property double offsetLeft: 0   //смещение описывающего прямоугольника по x
    property double offsetTop: 0    //смещение описывающего прямоугольника по y
    property double minWidth: 20    //минимальная ширина описывающего прямоугольника
    property double minHeight: 20   //минимальная высота описываюшего прямоугольника

    property int strokeWidth: 1                 //ширина линии фигуры
    property string strokeColor: "#000000"      //цвет линии
    property string fillColor                   //цвет заливки

    anchors {
        left: parent.left
        top: parent.top
        leftMargin: offsetLeft
        topMargin: offsetTop
    }

    Canvas {
        id: bboxCanvas

        visible: true
        anchors.fill:parent

        onPaint: {
            if (parent.vertices.length < 2)
                return;

            var ctx = getContext("2d");
            ctx.strokeStyle = strokeColor;
            ctx.lineWidth = strokeWidth;
            ctx.beginPath();
            ctx.moveTo(parent.vertices[0].x, parent.vertices[0].y);

            for (var i = 1; i < parent.vertices.length; i++) {
                ctx.lineTo(parent.vertices[i].x, parent.vertices[i].y);
            }

            if (parent.vertices.length > 2 && parent.isClosed) {
                ctx.lineTo(parent.vertices[0].x, parent.vertices[0].y);
                ctx.closePath();
            }

            if (parent.fillColor.length > 0) {
                ctx.fillStyle = parent.fillColor;
                ctx.fill();
            }

            ctx.stroke();
        }
    }

    BBoxActionPoint {
        id: topLeftCorner
        position: "topLeft"
    }

    BBoxActionPoint {
        id: topRightCorner
        position: "topRight"
    }

    BBoxActionPoint {
        id: bottomLeftCorner
        position: "bottomLeft"
    }

    BBoxActionPoint {
        id: bottomRightCorner
        position: "bottomRight"
    }

    BBoxActionPoint {
        id: topMiddle
        position: "topMiddle"
    }

    BBoxActionPoint {
        id: bottomMiddle
        position: "bottomMiddle"
    }

    BBoxActionPoint {
        id: leftMiddle
        position: "leftMiddle"
    }

    BBoxActionPoint {
        id: rightMiddle
        position: "rightMiddle"
    }
}
