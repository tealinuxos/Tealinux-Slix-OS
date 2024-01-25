import QtQuick 2.0;
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 5000
        running: false
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }
    
    Image {
        id: background
        source: "calamares_background.svg"
        anchors.fill: parent
    }
    
    Image {
        id: image
        source: "calamares_install_image.svg"
        width: 256
        height: 256
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Slide {
        
        ColumnLayout {
            anchors.leftMargin: 18
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label {
                Layout.fillWidth: true

                text: qsTr("Welcome to the Parch Linux!")
                font.pixelSize: 22
                font.bold: true
                color: "white"
            }

            Rectangle {
                height: 3
                width: 24
                radius: 2

                color: "white"
            }
            
            Text {
                Layout.fillWidth: true
                Layout.topMargin: 16

                font.pixelSize: 12
                color: "white"
                text: qsTr("Yet another distro based on Arch!")
                wrapMode: Text.WordWrap
            }
        }
    }

    Slide {
        
        ColumnLayout {
            anchors.leftMargin: 18
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label {
                Layout.fillWidth: true

                text: qsTr("Everything you need to get started.")
                font.pixelSize: 22
                font.bold: true
                color: "white"
            }

            Rectangle {
                height: 3
                width: 24
                radius: 2

                color: "white"
            }
            
            Text {
                Layout.fillWidth: true
                Layout.topMargin: 16

                font.pixelSize: 12
                color: "white"
                text: qsTr("Parch is a complete Operating System that ships the essential apps and services for the daily use: office applications, PDF reader, image editor")
                wrapMode: Text.WordWrap
            }
        }
    }

    Slide {
        
        ColumnLayout {
            anchors.leftMargin: 18
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label {
                Layout.fillWidth: true

                text: qsTr("Explore a universe of apps with AUR.")
                font.pixelSize: 22
                font.bold: true
                color: "white"
            }

            Rectangle {
                height: 3
                width: 24
                radius: 2

                color: "white"
            }
            
            Text {
                Layout.fillWidth: true
                Layout.topMargin: 16

                font.pixelSize: 12
                color: "white"
                text: qsTr("Thanks for using Parch Linux")
                wrapMode: Text.WordWrap
            }
        }
    }
}
