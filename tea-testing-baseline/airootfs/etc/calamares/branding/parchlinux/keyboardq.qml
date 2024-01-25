import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami

ResponsiveBase
{
    id: control

    title: stackView.currentItem.title
    subtitle: stackView.currentItem.subtitle
    icon.source: stackView.currentItem.icon

    stackView.initialItem: ListViewTemplate
    {
        id: _keyboardModelListView
        property string title: qsTr("Keyboard Model")
        property string subtitle: qsTr("Pick your preferred keyboard model or use the default one based on the detected hardware")
        property string icon : "cala-qml-keyboard-model"

        currentIndex: model.currentIndex

        model: config.keyboardModelsModel

        delegate: ListItemDelegate
        {
            id: _delegate
            label1.text: model.label
            onClicked:
            {
                _keyboardModelListView.model.currentIndex = index
                control.stackView.push(_keyboardLayoutsComponent)
            }
        }

        Button
        {
            Layout.fillWidth: true
            text: qsTr("Layouts")
            icon.name: "go-previous"
            onClicked: control.stackView.push(_keyboardLayoutsComponent)
        }
    }

    Component
    {
        id: _keyboardLayoutsComponent

        ListViewTemplate
        {
            id: _layoutsListView
            property string title: qsTr("Keyboard Layout")
            property string subtitle: config.prettyStatus
            property string icon : "cala-qml-keyboard-layout"

            currentIndex: model.currentIndex

            model: config.keyboardLayoutsModel

            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.label
                onClicked:
                {
                    _layoutsListView.model.currentIndex = index
                    _layoutsListView.positionViewAtIndex(index, ListView.Center)
                    control.stackView.push(_keyboardVariantsComponent)
                }
            }


            TextField
            {
                placeholderText: qsTr("Test your keyboard")

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }

            Button
            {
                Layout.fillWidth: true
                icon.name: "go-next"
                text: qsTr("Variants")
                onClicked: control.stackView.push(_keyboardVariantsComponent)
            }
        }
    }

    Component
    {
        id: _keyboardVariantsComponent

        ListViewTemplate
        {
            id: _variantsListView

            property string title: qsTr("Keyboard Layout Variant")
            property string subtitle: config.prettyStatus
            property string icon : "cala-qml-keyboard-layout-variant"
            
            currentIndex: model.currentIndex

            model: config.keyboardVariantsModel

            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.label
                onClicked:
                {
                    _variantsListView.model.currentIndex = index
                    _variantsListView.positionViewAtIndex(index, ListView.Center)
                }
            }
        }
    }
}
