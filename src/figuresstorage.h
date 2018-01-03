#ifndef FIGURESSTORAGE_H
#define FIGURESSTORAGE_H

#include <QUuid>
#include <QObject>

namespace Rosdistant {
    class Figure;

    /*
     2D-figures storage class
     Author: Rabinovich R.M.
     You can use & modificate the following code without any restrictions
     Date: 10.11.2017
     */
    class FiguresStorage
    {
    public:
        FiguresStorage();
        virtual ~FiguresStorage();

        //получить содержимое хранилища
        const QHash<QUuid, Figure*>& storage() const;

        //заполнить хранилище
        void setStorage(const QHash<QUuid, Figure*> &value);

        //удалить информацию в хранилище
        void resetStorage();

        //признак пустоты хранилища
        bool isEmpty() const;

        //получить указатель на фигуру в хранилище
        Figure* getFigure(const QUuid& uuid) const;

        //добавить фигуру в хранилище
        void addFigure(const QUuid &uuid, Figure* figure);
        void addFigure(Figure* figure);

        //удалить фигуру из хранилища
        void removeFigure(const QUuid &uuid);

        //заполнить хранилище данными из json-файла
        bool fillupFromFile(const QString& filePath);

        //сбросить сереализуемое содержимое хранилища в json-файл
        bool saveToFile(const QString& filePath) const;

    private:
        //хранилище фигур на сцене
        QHash<QUuid, Figure*> _storage;
    };

}

#endif // FIGURESSTORAGE_H
