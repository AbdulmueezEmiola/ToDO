#ifndef DATAENTRY_H
#define DATAENTRY_H
#include <QtCore>

class DataEntry
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QDate date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(QTime time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(QString note READ note WRITE setNote NOTIFY noteChanged)
    Q_PROPERTY(QString important READ important WRITE setImportant NOTIFY importantChanged)

public:
    DataEntry(QObject *parent = nullptr);
    ~DataEntry();
    QString title() const;
    QDate date() const;
    QTime time() const;
    QString note() const;
    QString important() const;
public slots:
    void setTitle(QString title);
    void setDate(QDate date);
    void setTime(QTime time);
    void setNote(QString note);
    void setImportant(QString important);
signals:
    void titleChanged(QString arg);
    void dateChanged(QDate arg);
    void timeChanged(QTime arg);
    void noteChanged(QString arg);
    void importantChanged(QString arg);
private:
    QString m_title;
    QDate m_date;
    QTime m_time;
    QString m_note;
    QString m_important;
};

#endif // DATAENTRY_H
