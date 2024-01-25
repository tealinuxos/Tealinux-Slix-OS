import io.calamares.ui 1.0
import io.calamares.core 1.0

import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

import org.kde.kirigami 2.7 as Kirigami

import "."

ResponsiveBase
{
    id: control

    title: stackView.currentItem.title
    subtitle: stackView.currentItem.subtitle
    message: stackView.currentItem.message
    icon.source: stackView.currentItem.icon

    stackView.initialItem: ListViewTemplate
    {
        id: _requirementsList
        property string title: qsTr("Welcome to ") + Branding.string(Branding.ProductName)
        property string subtitle: config.genericWelcomeMessage
        property string message: config.requirementsModel.satisfiedRequirements ? "All requirements have been satisfied." :  qsTr("<p>Please ensure this computer has enough storage, RAM, and a working Internet connection. %1.<br/>
        Setup can continue, but some features might be disabled.</p>").arg(Branding.string(Branding.VersionedName))
        property string icon : Branding.imagePath(Branding.ProductWelcome)
        model: config.unsatisfiedRequirements

        delegate: Control
        {
            id: _delegate

            background: Rectangle
            {
                color: model.satisfied ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.negativeTextColor
                opacity: 0.2
            }

            width: ListView.view.width
            height: 72

            RowLayout
            {
                id: _template
                anchors.fill: parent

                Item
                {
                    Layout.alignment: Qt.AlignCenter
                    implicitWidth: 48
                    implicitHeight: 48
                    Kirigami.Icon
                    {
                        source: model.satisfied ? "checkmark" : (model.mandatory ? "error" : "emblem-info")
                        height: 22
                        width: 22
                        anchors.centerIn: parent
                    }
                }

                ColumnLayout
                {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    Layout.margins: Kirigami.Units.smallSpacing
                    spacing : 0

                    Label
                    {
                        Layout.fillWidth: true
                        text: model.name
                        font.bold: true
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: !model.satisfied ?  model.negatedText : model.details
                        wrapMode: Text.Wrap
                    }
                }


            }
        }

        RowLayout
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 64

            spacing: Kirigami.Units.largeSpacing* 2

            Button
            {
                Layout.fillWidth: true
                text: "About"
                icon.name: "documentinfo"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"

                visible: Branding.string(Branding.ProductUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.ProductUrl))
            }

            Button
            {
                Layout.fillWidth: true
                text: qsTr("Support")
                icon.name: "help-contents"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                visible: Branding.string(Branding.SupportUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.SupportUrl))
            }

            Button
            {
                Layout.fillWidth: true
                text: qsTr("Known issues")
                icon.name: "tools-report-bug"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                visible: Branding.string(Branding.KnownIssuesUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.KnownIssuesUrl))
            }

            Button
            {
                Layout.fillWidth: true
                text: qsTr("Release notes")
                icon.name: "document-edit"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                visible: Branding.string(Branding.ReleaseNotesUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.ReleaseNotesUrl))
            }
        }

        Button
        {
            Layout.fillWidth: true
            text: qsTr("Language")
            onClicked: control.stackView.push(_langComponent)
            enabled: true
        }
    }


    Component
    {
        id: _langComponent
        ListViewTemplate
        {
            id: _langList

            property string title : qsTr("Language")
            property string subtitle:  qsTr("Select your preferred language to continue with the installation")
            property string icon : "cala-qml-language"

            currentIndex: config.localeIndex
            model: config.languagesModel
            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.label
                label2.text: model.englishLabel

                onClicked: config.localeIndex = index
            }
        }
    }
}
