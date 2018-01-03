import QtQuick 2.0

Canvas {
    property double width: 0
    property double height: 0

    onPaint: {
        onPaint: {
            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(20, 100);//start point
            ctx.lineTo(150, 100);
            ctx.lineTo(150, 200);
            ctx.lineTo(20, 200);
            ctx.lineTo(20, 100);
            ctx.stroke();
        }
    }
}
