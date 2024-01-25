import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10

import org.mauikit.controls 1.3 as Maui
import org.kde.kirigami 2.7 as Kirigami
import "."

ResponsiveBase
{
    id: control

    title: qsTr("Summary")
    subtitle: qsTr("Summary of the installation")
    message: qsTr("<p>Review the steps that will be taken before the system installation starts.</p>")
    icon.source: "cala-qml-summary"


    stackView.initialItem: ListViewTemplate
    {
        currentIndex: -1
        model: config.summaryModel
        delegate: Maui.ItemDelegate
        {
            id: _delegate

            width: ListView.view.width
            height: _template.implicitHeight + Maui.Style.space.medium

            Maui.ListItemTemplate
            {
                id: _template
                anchors.fill: parent
                anchors.margins: Maui.Style.space.medium
                iconSource: "documentinfo"
                iconSizeHint: 32
                headerSizeHint: iconSizeHint
                label1.text: model.title
                label2.text: model.message
                label2.wrapMode: Text.Wrap
                label2.textFormat: Text.AutoText
            }
        }
    }
}
