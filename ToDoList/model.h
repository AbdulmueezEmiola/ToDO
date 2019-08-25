#ifndef MODEL_H
#define MODEL_H
#include <QAbstractListModel>
#include <QDateTime>
class Entry{
public:
    Entry(const QString &title, const QDate &date, const QTime &time, const QString &note, const QString &important, const int &position);
    QString title() const;
    QDate date()const;
    QTime time()const;
    QString note() const;
    QString important()const;
    int position()const;
private:
    QString m_title;
    QDate m_date;
    QTime m_time;
    QString m_note;
    QString m_important;
    int m_position;
};

class Model: public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY( int count READ rowCount() NOTIFY rowCountChanged() )
public:
    enum EntryRoles{
        TitleRole = Qt::UserRole+1,
        DateRole,
        TimeRole,
        NoteRole,
        ImportantRole,
        PositionRole
    };
    Model(QObject *parent = nullptr);
    void addEntry(const Entry &entry);
    int rowCount(const QModelIndex &parent = QModelIndex())const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole)const;
    Q_INVOKABLE void writeToFile();
    Q_INVOKABLE void remove(int index);
    Q_INVOKABLE void replace(int index, const QString &title, const QDate &date, const QTime &time, const QString &note, const QString &important);
    Q_INVOKABLE QVariantMap get( int rowNumber ) const;
signals:
    void rowCountChanged(int);
protected:
    QHash<int,QByteArray>roleNames()const;
private:
    QList<Entry> m_entries;
    void readFromFile();
    void helperFunction();
};

#endif // MODEL_H
