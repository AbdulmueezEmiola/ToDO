#include "fileio.h"

FileIO::FileIO(QObject *parent):
    QObject(parent)
{
    m_source = QUrl::fromLocalFile("input.txt");
}
FileIO::~FileIO(){

}
void FileIO::read(){
    if(m_source.isEmpty()){
        return;
    }
    QFile file(m_source.toLocalFile());
    if(!file.exists()){
        qWarning()<<"Does not exists: "<<m_source.toLocalFile();
        return;
    }
    if(file.open(QIODevice::ReadOnly)){
        while(!file.atEnd()){
            QString titleTemp = file.readLine();
            titleTemp.chop(1);
            m_member.setTitle(titleTemp);
            QString dateTemp = file.readLine();
            dateTemp.chop(1);
            m_member.setDate(QDate::fromString(dateTemp,"dd:MM:yy"));
            QString timeTemp = file.readLine();
            timeTemp.chop(1);
            m_member.setTime(QTime::fromString(timeTemp,"h:m a"));
            QString noteTemp = file.readLine();
            noteTemp.chop(1);
            m_member.setNote(noteTemp);
            QString importantTemp = file.readLine();
            importantTemp.chop(1);
            m_member.setImportant(importantTemp);
            m_memberList.append(m_member);
        }
    }
    emit memberListChanged(m_memberList);
}
void FileIO::write(){
    if(m_source.isEmpty()){
        qWarning()<<"Can't open file"<<m_source<<endl;
        return;
    }
    QFile file(m_source.toLocalFile());
    if(file.open(QIODevice::WriteOnly | QIODevice::Append)){
            QTextStream stream(&file);
            stream <<m_member.title()<<endl;
            stream <<m_member.date().toString("dd:MM:yyyy")<<endl;
            stream <<m_member.time().toString("hh:mm")<<endl;
            stream <<m_member.note()<<endl;
            stream <<m_member.important()<<endl;
    }
}

QUrl FileIO::source() const{
    return m_source;
}
void FileIO::setSource(QUrl source){
    if(m_source == source){
        return;
    }
    m_source = source;
    emit sourceChanged(m_source);
}
QList<DataEntry> FileIO::memberList()const{
    return m_memberList;
}
void FileIO::setMemberList(QList<DataEntry> memberList){
    for(int i =0;i<memberList.count();++i){
        m_memberList.append(memberList.at(i));
    }
    emit memberListChanged(m_memberList);
}
DataEntry FileIO::member()const{
    return m_member;
}
void FileIO::setMember(DataEntry member){
    m_member = member;
    emit memberChanged(m_member);
}
