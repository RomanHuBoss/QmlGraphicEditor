#ifndef QTQMLINTERACTOR_H
#define QTQMLINTERACTOR_H

#include <QQmlApplicationEngine>
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
        QtQmlInteractor();
        ~QtQmlInteractor();

        bool isRootContextLoaded();
    private:
        QQmlApplicationEngine _engine;
        FiguresStorage _storage;
    public slots:
        void onShowSettings();
        void onNewScene();
        bool onSaveScene();
        bool onRedo();
        bool onUndo();
    signals:
        void raiseAlertifyError(const QString& text);
        void raiseAlertifyWarning(const QString& text);
    };

}

#endif // QTQMLINTERACTOR_H
