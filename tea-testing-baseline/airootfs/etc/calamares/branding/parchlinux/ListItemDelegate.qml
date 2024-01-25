import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami

ItemDelegate
{
    id: control


    property alias label1 : _label1
    property alias label2 : _label2

    hoverEnabled: true

    property bool isCurrentItem: ListView.isCurrentItem
    background: Rectangle
    {
        color: isCurrentItem || hovered ? Kirigami.Theme.highlightColor : Qt.lighter(Kirigami.Theme.backgroundColor)
        opacity: isCurrentItem || hovered ? 1 : 0.4
    }

    implicitWidth: ListView.view.width
    implicitHeight: Math.max(48, _layout.implicitHeight + Kirigami.Units.largeSpacing *2)

    contentItem: RowLayout
    {
        id: _layout
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        Label
        {
            id: _label1
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Qt.AlignLeft
            color: isCurrentItem ? Kirigami.Theme.highlightedTextColor : Kirigami.Theme.textColor
        }

          Label
        {
            id: _label2
            visible: text.length
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.4
            horizontalAlignment: Qt.AlignRight
            color: isCurrentItem ? Kirigami.Theme.highlightedTextColor : Kirigami.Theme.textColor
            opacity: isCurrentItem ? 1 : 0.7
            font.weight: Font.Light
            wrapMode: Text.Wrap
        }

        Kirigami.Icon
        {
            source: "emblem-default"
            Layout.preferredWidth: 22
            Layout.preferredHeight: 22
            color: Kirigami.Theme.highlightedTextColor
            visible: isCurrentItem
        }
    }
}
