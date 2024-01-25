import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import QtGraphicalEffects 1.0
import io.calamares.ui 1.0
import io.calamares.core 1.0

import "."

Page
{
  id: control
	width: parent.width
	height: parent.height
		background: Item
		{
			id: _background

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

				source: Branding.imagePath(Branding.ProductWallpaper)
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
		}  
		
		Column
{
anchors.fill: parent
Rectangle 
{
    id: hello
    width: 200
    height: 100
    color: "red"

    Text {
        anchors.centerIn: parent
        text: Branding.string(Branding.VersionedName)
    }
}

/* perhaps we could show a branding image here */

Repeater
{
    model: ViewManager
    Rectangle {
        width: 200
        height: 75
        color: "black"

        Text {
            color: completed ? "green" : "yellow"
            text: display
        }
    }
}

}
    
}


