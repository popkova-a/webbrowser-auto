import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebEngine 1.8
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

TextField {

    id: urltext
    anchors {
        verticalCenter: parent.verticalCenter
        left: parent.left
        right: parent.right
    }
    font.pointSize: 14
    selectByMouse: true
    horizontalAlignment: Text.AlignLeft
    text: webview.url
    onAccepted: { webview.url = fixUrl(displayText) }
    placeholderText: webview.url
 }
