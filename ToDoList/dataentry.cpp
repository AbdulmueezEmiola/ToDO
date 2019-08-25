#include "dataentry.h"

DataEntry::DataEntry(QObject *parent)
{

}
QString DataEntry::title() const{
    return m_title;
}
QDate DataEntry::date() const{
    return m_date;
}
QTime DataEntry::time() const{
    return m_time;
}
QString DataEntry::note() const{
    return m_note;
}
QString DataEntry::important() const{
    return m_important;
}
void DataEntry::setTitle(QString title){
    if(m_title == title){
        return;
    }
    m_title = title;
    emit titleChanged(title);
}
void DataEntry::setDate(QDate date){
    if(m_date == date){
        return;
    }
    m_date = date;
    emit dateChanged(date);
}
void DataEntry::setTime(QTime time){
    if(m_time == time){
        return;
    }
    m_time = time;
    emit  timeChanged(time);
}
void DataEntry::setNote(QString note){
    if(m_note == note){
        return;
    }
    m_note = note;
    emit noteChanged(note);
}
void DataEntry::setImportant(QString important){
    if(m_important == important){
        return;
    }
    m_important = important;
    emit importantChanged(important);
}
