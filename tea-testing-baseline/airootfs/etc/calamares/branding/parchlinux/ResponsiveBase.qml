import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3

import org.kde.kirigami 2.7 as Kirigami

import QtGraphicalEffects 1.0

import "."

import io.calamares.ui 1.0
import io.calamares.core 1.0

Page
{
    id: control

    property string subtitle
    property string message
    property alias icon : _icon

    property alias stackView: _stackView

    default property alias content : _card.data

        property alias backButton : _backButton

        signal goBack()

        background: Rectangle
        {
            id: _background
            color: control.Kirigami.Theme.backgroundColor

            Image
            {
                id: _wallpaper
                height: parent.height
                width: parent.width

                sourceSize.height: 600
                sourceSize.width: 800

                fillMode: Image.PreserveAspectCrop
                antialiasing: false
                smooth: false
                asynchronous: true
                cache: true
                source: "./calamares_bg_image.png"
            }

            FastBlur
            {
                id: fastBlur
                anchors.fill: parent
                source: _wallpaper
                radius: 130
                transparentBorder: false
                cached: true
            }

            OpacityMask
            {
                source: mask
                maskSource: parent
            }

            LinearGradient
            {
                id: mask
                anchors.fill: parent
                gradient: Gradient
                {
                    GradientStop { position: 0.6; color: "transparent"}
                    GradientStop { position: 0.9; color: _background.color}
                }

                start: Qt.point(0, 0)
                end: Qt.point(0, control.height-48)
            }
        }

        ColumnLayout
        {
            anchors.centerIn: parent
            height: Math.min(800, parent.height * 0.95)
            width: Math.min(1200, parent.width * 0.95)
            Page
            {
                id: _card
                clip: true

                Layout.fillWidth: true
                Layout.fillHeight: true

                Component.onCompleted: fadeIn.start()

                NumberAnimation on opacity
                {
                    id: fadeIn
                    duration: 150
                    from: 0
                    to: 1.0
                    easing.type: Easing.OutQuad
                }

                header: ToolBar
                {
                    visible: _stackView.depth > 1
                    background: null

                    ToolButton
                    {
                        id:_backButton
                        text: _stackView.get(Math.max(0, _stackView.currentItem.StackView.index - 1), StackView.DontLoad).title
                        icon.name: "go-previous"
                        flat: true
                        onClicked:
                        {
                            if(_stackView.depth > 1)
                            {
                                _stackView.pop()
                            }

                            control.goBack()

                        }
                    }
                }

                background: Rectangle
                {
                    color: Kirigami.Theme.backgroundColor
                    radius: 20
                }

                RowLayout
                {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing * 6
                    spacing: Kirigami.Units.largeSpacing * 2

                    ColumnLayout
                    {
                        id: _content
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.margins: Kirigami.Units.largeSpacing * 2
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                        spacing:  Kirigami.Units.largeSpacing * 2

                        Item
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100

                            Kirigami.Icon
                            {
                                id: _icon
                                height: 80
                                width: height
                                anchors.centerIn: parent
                                FadeBehavior on source { fadeProperty: "scale" }
                            }
                        }

                        Label
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Math.min(implicitHeight, 200)
                            horizontalAlignment: Qt.AlignHCenter
                            wrapMode: Text.Wrap
                            elide: Text.ElideMiddle
                            text: control.title
                            font.bold: true
                            font.weight: Font.Bold
                            font.pointSize: 24
                            FadeBehavior on text { }
                        }

                        Label
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Math.min(implicitHeight, 200)
                            horizontalAlignment: Qt.AlignHCenter
                            wrapMode: Text.Wrap
                            elide: Text.ElideMiddle
                            text: control.subtitle
                            font.weight: Font.Light
                            font.pointSize: 12
                            FadeBehavior on text { }
                        }

                        Label
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Math.min(implicitHeight, 200)
                            horizontalAlignment: Qt.AlignHCenter
                            wrapMode: Text.Wrap
                            elide: Text.ElideMiddle
                            text: control.message
                            font.weight: Font.Light
                            font.pointSize: 10
                            FadeBehavior on text { }
                        }
                    }

                    StackView
                    {
                        id: _stackView
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                        Layout.margins: Kirigami.Units.largeSpacing * 2

                        Layout.minimumWidth: 300
                        Layout.maximumWidth: 500

                        Layout.maximumHeight:  currentItem.implicitHeight
                        Layout.minimumHeight: 200


                        clip: true

                        pushEnter: Transition
                        {
                            NumberAnimation {
                                property: "opacity"
                                duration: 150
                                to: 1
                                easing.type: Easing.OutQuad
                            }
                        }

                        popEnter: Transition
                        {
                            NumberAnimation {
                                property: "opacity"
                                duration: 150
                                to: 1
                                easing.type: Easing.OutQuad
                            }
                        }

                        popExit: Transition
                        {
                            NumberAnimation {
                                property: "opacity"
                                duration: 150
                                to: 0
                                easing.type: Easing.InQuad
                            }
                        }

                        pushExit: Transition
                        {
                            NumberAnimation {
                                property: "opacity"
                                duration: 150
                                to: 0
                                easing.type: Easing.InQuad
                            }
                        }
                    }
                }
            }

            ViewStepsBar
            {
                Layout.fillWidth: true
                Layout.maximumWidth: 900
                Layout.minimumWidth: 400
                Layout.alignment: Qt.AlignCenter
            }

        }

        //footer: Column
        //{
            //width: parent.width

            //Item
            //{
                //height: 100
                //width: parent.width

                //Row
                //{
                    //spacing: Kirigami.Units.largeSpacing
                    //anchors.centerIn: parent

                    //Button
                    //{
                        ////text: ViewManager.quitLabel;
                        //icon.name: ViewManager.quitIcon;

                        //ToolTip.visible: hovered
                        //ToolTip.timeout: 5000
                        //ToolTip.delay: 1000
                        //ToolTip.text: ViewManager.quitTooltip;

                        //enabled: ViewManager.quitEnabled;
                        //visible: ViewManager.quitVisible;
                        //onClicked: { ViewManager.quit(); }
                    //}

                    //Button
                    //{
                        //text: ViewManager.backLabel;
                        //icon.name: ViewManager.backIcon;

                        //enabled: ViewManager.backEnabled;
                        //visible: true;
                        //onClicked: { ViewManager.back(); }

                        //height: implicitHeight
                        //Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                        //Kirigami.Theme.textColor: "#fff"
                    //}

                    //Button
                    //{

                        //height: implicitHeight

                        //text: ViewManager.nextLabel;
                        //icon.name: ViewManager.nextIcon;

                        ////                     enabled: ViewManager.nextEnabled;
                        //enabled: true;
                        //visible: true;
                        //onClicked: { ViewManager.next(); }
                        //Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                        //Kirigami.Theme.textColor: "#fff"
                    //}
                //}
            //}
        //}
}
