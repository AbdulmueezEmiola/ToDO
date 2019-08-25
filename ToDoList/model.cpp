#include "model.h"
#include <QUrl>
#include <QFile>
#include <QDebug>
#include <QVariantMap>
#include <QHash>
Entry::Entry(const QString &title, const QDate &date, const QTime &time, const QString &note, const QString &important,const int &position):
    m_title(title),m_date(date),m_time(time),m_note(note),m_important(important),m_position(position)
{

}
QString Entry::title() const{
    return m_title;
}
QDate Entry::date() const{
    return m_date;
}
QTime Entry::time()const{
    return m_time;
}
QString Entry::note() const{
    return m_note;
}
QString Entry::important() const{
    return m_important;
}
int Entry::position() const{
    return m_position;
}
Model::Model(QObject *parent):
    QAbstractListModel (parent)
{
    readFromFile();
}
void Model::addEntry(const Entry &entry){
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    m_entries<<entry;
    endInsertRows();
}
int Model::rowCount(const QModelIndex &parent) const{
    Q_UNUSED(parent)
    return m_entries.count();
}
void Model::remove(int index){
    if(index < 0 || index > m_entries.count()){
        return;
    }
    emit beginRemoveRows(QModelIndex(), index, index);
    m_entries.removeAt(index);
    qDebug()<<m_entries.count()<<"From qt";
    qDebug()<<"Before the helper function"<<m_entries.count();;
    for(int i =0;i<m_entries.count();++i){
        qDebug()<<m_entries.at(i).title()<< m_entries.at(i).position();
    }
    helperFunction();
    qDebug()<<"After the helper function"<<m_entries.count();
    for(int i =0;i<m_entries.count();++i){
        qDebug()<<m_entries.at(i).title()<< m_entries.at(i).position();
    }
    emit endRemoveRows();
    emit rowCountChanged(m_entries.count());

}
void Model::helperFunction(){
    QList<Entry> tempList;
    for(int i = 0;i< m_entries.count();++i){
        QString titleTemp = m_entries.at(i).title();
        QDate dateTemp = m_entries.at(i).date();
        QTime timeTemp = m_entries.at(i).time();
        QString noteTemp = m_entries.at(i).note();
        QString importantTemp = m_entries.at(i).important();
        Entry temp(titleTemp,dateTemp,timeTemp,noteTemp,importantTemp,i);
        tempList.append(temp);
    }
    m_entries = tempList;
}
void Model::readFromFile(){        
    QUrl source = QUrl::fromLocalFile("input.txt");
    QFile file(source.toLocalFile());
    if(!file.exists()){
        qWarning()<<"Does not exists: "<<source.toLocalFile();
        return ;
    }
    if(file.open(QIODevice::ReadOnly)){        
        int count =0;
        while(!file.atEnd()){
            QString titleTemp = file.readLine();
            titleTemp.chop(1);
            QString dateTempa = file.readLine();
            dateTempa.chop(1);
            QDate dateTemp = QDate::fromString(dateTempa,"dd:MM:yyyy");
            if(dateTemp< QDate::currentDate()){
                continue;
            }
            QString timeTempa = file.readLine();
            timeTempa.chop(1);
            QTime timeTemp = QTime::fromString(timeTempa,"hh:mm");
            QString noteTemp = file.readLine();
            noteTemp.chop(1);
            QString importantTemp = file.readLine();
            importantTemp.chop(1);
            Entry entryTemp(titleTemp,dateTemp,timeTemp,noteTemp,importantTemp,count++);
            addEntry(entryTemp);
        }
    }
    for(int i =0;i<m_entries.count();++i){
        qDebug()<<m_entries.at(i).title()<< m_entries.at(i).position();
    }
}
void Model::writeToFile(){
    QUrl source = QUrl::fromLocalFile("input.txt");
    QFile file(source.toLocalFile());
    if(!file.exists()){
        qWarning()<<"Does not exists: "<<source.toLocalFile();
        return ;
    }
    if(file.open(QIODevice::WriteOnly)){
            QTextStream stream(&file);
            for(int i =0;i<m_entries.count();++i){
                stream <<m_entries.at(i).title()<<endl;
                stream <<m_entries.at(i).date().toString("dd:MM:yyyy")<<endl;
                stream <<m_entries.at(i).time().toString("hh:mm")<<endl;
                stream <<m_entries.at(i).note()<<endl;
                stream <<m_entries.at(i).important()<<endl;
            }
    }
}
QVariant Model::data(const QModelIndex &index, int role) const{
    if(index.row()<0||index.row()>= m_entries.count()){
        return QVariant();
    }
    const Entry &entry = m_entries[index.row()];
    if(role == TitleRole){
        return entry.title();
    }
    if(role == DateRole){
        return entry.date();
    }
    if(role == TimeRole){
        return entry.time();
    }
    if(role == NoteRole){
        return entry.note();
    }
    if(role == ImportantRole){
        return entry.important();
    }
    if(role == PositionRole){
        return entry.position();
    }
    return QVariant();
}
QHash<int, QByteArray> Model::roleNames() const{
    QHash<int,QByteArray> roles;
    roles[TitleRole] = "title";
    roles[DateRole] = "date";
    roles[TimeRole] = "time";
    roles[NoteRole] = "note";
    roles[ImportantRole] = "important";
    roles[PositionRole] = "position";
    return roles;
}
QVariantMap Model::get( int rowNumber ) const
{
    QVariantMap map;
    QHash<int,QByteArray> roleName = roleNames();
    foreach (int i, roleName.keys())
    {
        map[roleName.value(i)] = data( index( rowNumber,0 ), i );
    }
    return map;
}
void Model::replace(int index, const QString &title, const QDate &date, const QTime &time, const QString &note, const QString &important){
    Entry entryTemp(title,date,time,note,important,index);
    m_entries.replace(index,entryTemp);
}
