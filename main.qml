import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebEngine 1.8
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Window {

    visible: true
    width: 1280
    height: 960
    x: -2
    y: 20
    title: qsTr("Web Browser")

    TabView {

        id: tabs

        function createEmptyTab(profile) {
            var tab = addTab("", tabComponent);
            tab.active = true;
            tab.title = Qt.binding(function() { return tab.item.currentwebview.title});
            tab.item.currentwebview.profile = profile;
            return tab;
        }

        width: parent.width
        height: parent.height

        property QtObject defaultProfile: WebEngineProfile {
            storageName: "Profile"
            offTheRecord: false
        }

        Component.onCompleted: createEmptyTab(defaultProfile)

        style: TabViewStyle {

            property color frameColor: "#C0C0C0"
            property color fillColor: "#FFFFFF"
            property color nonSelectedColor: "#A9A9A9"
            frameOverlap: 0
            frame: Rectangle {
                color: "#FFFFFF"
                border.color: frameColor
            }
            tab: TabRectangle {}
            tabsMovable: true
            tabBar:
                Rectangle {
                width: parent.width
                height: 20
                color: "#D3D3D3"

                Button {
                    x: (tabs.width / (tabs.count + 2))*tabs.count + 6
                    anchors.verticalCenter: parent.verticalCenter
                    height: 10
                    width: 10
                    style: ButtonStyle {
                        background: Rectangle {
                            implicitWidth: 10
                            implicitHeight: 10
                            color: control.hovered ? "#C0C0C0" : "#696969"
                            Text
                            {
                                text: "+"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "#000000"
                                font.pointSize: 10
                            }
                        }
                    }
                    onClicked:
                    {
                        tabs.createEmptyTab(tabs.defaultProfile);
                        tabs.currentIndex = tabs.count - 1;
                    }
                 }
            }
        }
       Component
       {
         id: tabComponent
         TabWindow {}
       }
     }
}
