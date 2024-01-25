import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3

import org.kde.kirigami 2.7 as Kirigami
import "."

ResponsiveBase
{
    id: control

    title: qsTr("Finished")
    subtitle: qsTr("Installation process has finished")
    message: qsTr("<p>A full log of the install is available as installation.log in the home directory of the Live user.<br/>
    This log is copied to /var/log/installation.log of the target system.</p>")
    icon.source: "cala-qml-finished"


    stackView.initialItem:  Item
    {

        Column
        {
            width: parent.width * 0.7
            anchors.centerIn: parent
            spacing: Kirigami.Units.largeSpacing * 3
            Label
            {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                text:  qsTr("%1 has been installed on your computer.<br/>
                You may now restart into your new system, or continue using the Live environment.").arg(Branding.string(Branding.ProductName))
            }


            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6

                Button {
                    text: qsTr("Close Installer")
                    icon.name: "application-exit"
                    onClicked: { ViewManager.quit(); }
                }

                Button {
                    text: qsTr("Restart System")
                    icon.name: "document-revert"
                    onClicked: { config.doRestart(true); }
                }
            }
        }
    }

    function onActivate()
    {
    }

    function onLeave()
    {
    }

}
