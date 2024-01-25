import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
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

    property string currentRegion
    property string currentZone

    stackView.initialItem: ListViewTemplate
    {
        id: _regionListView

        property string title: qsTr("Region")
        property string subtitle: qsTr("Pick your preferred region or use the default one based on your current location")
        property string message:  qsTr("Select your preferred zone within your location to continue with the installation")
        property string icon : "cala-qml-region"

        model: config.regionModel
        currentIndex : -1

        delegate: ListItemDelegate
        {
            id: _delegate
            label1.text:  model.name
            onClicked:
            {
                _regionListView.currentIndex = index
                control.currentRegion = model.name
                config.regionalZonesModel.region = control.currentRegion
                control.stackView.push(_zonesListComponent)
            }
        }

        Button
        {
            Layout.fillWidth: true
            text: qsTr("Timezones")
            icon.name: "go-previous"
            onClicked: control.stackView.push(_zonesListComponent)
        }
    }

    Component
    {
        id: _zonesListComponent

        ListViewTemplate
        {
            id: _zonesListView
            property string title: qsTr("Timezone")
            property string subtitle: config.prettyStatus
            property string message: ""
            property string icon : "cala-qml-timezone"

            model: config.regionalZonesModel
            currentIndex : -1

            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.name
                onClicked:
                {
                    _zonesListView.currentIndex = index
                    control.currentZone = model.name

                    _zonesListView.listView.positionViewAtIndex(index, ListView.Center)

                    config.setCurrentLocation(control.currentRegion, control.currentZone)

                }
            }
        }
    }
}

