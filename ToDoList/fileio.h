#ifndef FILEIO_H
#define FILEIO_H
#include <QtCore>
#include <iostream>
struct DataEntry{
    Q_GADGET
    Q_PROPERTY(QString title READ title WRITE setTitle)
    Q_PROPERTY(QDate date READ date WRITE setDate )
    Q_PROPERTY(QTime time READ time WRITE setTime )
    Q_PROPERTY(QString note READ note WRITE setNote )
    Q_PROPERTY(QString important READ important WRITE setImportant )
public:
    QString title()const{
        return m_title;
    }
    QDate date() const{
        return m_date;
    }
    QTime time() const{
        return m_time;
    }
    QString note()  const{
        return m_note;
    }
    QString important() const{
        return m_important;
    }
public slots:
    void setTitle(QString title){
        if(m_title == title){
            return;
        }
        m_title = title;
        //emit titleChanged(title);
    }
    void setDate(QDate date){
        if(m_date == date){
            return;
        }
        m_date = date;
        //emit dateChanged(date);
    }
    void setTime(QTime time){
        if(m_time == time){
            return;
        }
        m_time = time;
        //emit  timeChanged(time);
    }
    void setNote(QString note){
        if(m_note == note){
            return;
        }
        m_note = note;
        //emit noteChanged(note);
    }
    void setImportant(QString important){
        if(m_important == important){
            return;
        }
        m_important = important;
        //emit importantChanged(important);
    }
/*signals:
    void titleChanged(QString arg);
    void dateChanged(QDate arg);
    void timeChanged(QTime arg);
    void noteChanged(QString arg);
    void importantChanged(QString arg);*/
private:
    QString m_title;
    QDate m_date;
    QTime m_time;
    QString m_note;
    QString m_important;

};
Q_DECLARE_METATYPE(DataEntry)
class FileIO: public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(FileIO)
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QList<DataEntry> memberList READ memberList WRITE setMemberList NOTIFY memberListChanged)
    Q_PROPERTY(DataEntry member READ member WRITE setMember NOTIFY memberChanged)
public:
    FileIO(QObject *parent = nullptr);
    ~FileIO();
    Q_INVOKABLE void read();
    Q_INVOKABLE void write();
    QUrl source() const;
    QList<DataEntry>memberList()const;
    DataEntry member()const;
public slots:
    void setSource(QUrl source);
    void setMemberList(QList<DataEntry> memberList);
    void setMember(DataEntry member);
signals:
    void sourceChanged(QUrl arg);
    void memberListChanged(QList<DataEntry> memberList);
    void memberChanged(DataEntry member);
private:
    QUrl m_source;
    QList<DataEntry> m_memberList;
    DataEntry m_member;
};

#endif // FILEIO_H
