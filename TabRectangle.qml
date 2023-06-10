import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {

    id: tabRectangle
    color: styleData.selected ? fillColor : nonSelectedColor
    border.width: 1
    border.color: frameColor
    implicitWidth: tabs.width / (tabs.count + 2);
    implicitHeight:  20
    Rectangle { height: parent.height ; width: 1; color: frameColor;}
    Rectangle { x: parent.width - 2; height: parent.height ; width: 1; color: frameColor;}
    Rectangle {

        anchors.left: parent.left
        height: parent.height - parent.border.width - 1
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - 15
        color: parent.color
        clip: true
        Text {
            id: text
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            text: styleData.title
            elide: Text.ElideRight
            color: "#000000"
            font.pointSize: 12
            font.italic: true
        }
    }
    Button {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 4
        height: 10
        style: ButtonStyle {
            background: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                color: control.hovered ? "#DC143C" : tabRectangle.color
                Text
                {
                    text: "X"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: control.hovered ? "#FFFFFF" : "#000000"
                }
            }
        }
        onClicked:
        {
            tabs.removeTab(styleData.index);
            if(!tabs.count)
                tabs.createEmptyTab(tabs.defaultProfile);
        }
    }
}
