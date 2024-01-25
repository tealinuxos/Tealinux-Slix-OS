import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami

Item
{
    id: control
    property alias model : _listView.model
    property alias delegate : _listView.delegate
    property alias contentHeight : _listView.contentHeight
    property alias currentIndex : _listView.currentIndex
    property alias currentItem : _listView.currentItem
    property alias listView : _listView

    default property alias content : _content.data

        implicitHeight: _content.implicitHeight

        ColumnLayout
        {
            id: _content
            anchors.fill: parent

            spacing: Kirigami.Units.largeSpacing

            ListView
            {
                id: _listView
                Layout.minimumHeight: 0
                Layout.preferredHeight: contentHeight
                Layout.maximumHeight:  500
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignCenter
                spacing: Kirigami.Units.smallSpacing
                clip: true
                boundsBehavior: Flickable.StopAtBounds

                Rectangle
                {
                    z: control.z - 1
                    anchors.fill: parent
                    color: Qt.lighter(Kirigami.Theme.backgroundColor)
                    radius: 5
                    opacity: 0.5
                }

            }
        }

}

