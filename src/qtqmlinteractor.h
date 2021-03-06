#ifndef QTQMLINTERACTOR_H
#define QTQMLINTERACTOR_H

#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QObject>
#include "figuresstorage.h"

namespace Rosdistant {

    /*
     Class provides interaction between QML & Qt via signals/slots mechanism
     Author: Rabinovich R.M.
     You can use & modificate the following code without any restrictions
     Date: 10.11.2017
     */
    class QtQmlInteractor: public QObject
    {
        Q_OBJECT
    public:
        const QString sceneFileExtension = "json";

        QtQmlInteractor(const QGuiApplication * const app);
        ~QtQmlInteractor();

        bool isRootContextLoaded();
    private:
        QQmlApplicationEngine _engine;
        QGuiApplication const * const _app;
        FiguresStorage _storage;
        QString _mode;
        QString _drownFigure;
    public slots:
        void onNewScene();
        void onSelectSceneFile(const QUrl& fileUrl);
        bool onAddQmlFigure(const QVariantMap& data);
        bool onRotateQmlFigure(const QString& uid, double angle);
        bool onResizeQmlFigure(const QString &uuid, double scaleLeft, double scaleRight, double scaleTop, double scaleBottom, double offsetLeft, double offsetTop);
        bool onFillQmlFigure(const QString& uid, const QString& color);
        bool onMoveQmlFigure(const QString& uid, double dx, double dy);
        bool onRemoveQmlFigure(const QString& uid);
        int figuresQuant() const;
        bool onSaveScene(const QUrl &fileUrl);
    signals:
        void raiseRemoveQmlFigure(const QString& uuid);
        void raiseAlertifyError(const QString& text);
        void raiseAlertifyWarning(const QString& text);
        void raiseAlertifyInfo(const QString& text);
        void raiseDrawFigureOnScene(const QVariantMap& data);
    };

}

#endif // QTQMLINTERACTOR_H
