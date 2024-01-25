import QtQuick 2.10
import QtQuick.Controls 2.10
import org.kde.kirigami 2.7 as Kirigami

Item
{
    id: control
   default property alias content: _content.data
       implicitHeight: _content.implicitHeight + (Kirigami.Units.largeSpacing * 2.5)

       property alias title : _label1.text
       property alias subtitle :_label2.text

    Rectangle
    {
        anchors.fill: parent
        color: Qt.lighter(control.Kirigami.Theme.backgroundColor)
        opacity: 0.7
    }

    Column
    {
        id: _content
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing
        spacing: Kirigami.Units.smallSpacing

        Label
        {
            id: _label1
            width: parent.width
            wrapMode: Text.WordWrap
        }

        Label
        {
            id: _label2
            visible: text.length
            width: parent.width
            font.weight: Font.Thin
            font.pointSize: 8
            wrapMode: Text.WordWrap
        }
    }
}
