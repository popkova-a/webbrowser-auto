import Qt.labs.settings 1.0
import QtQml 2.2
import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Controls.Private 1.0 as QQCPrivate
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import QtWebEngine 1.7

Menu {
    id: historyMenu
    Instantiator {
        model: webview.navigationHistory.items
        MenuItem {
            text: model.title
            onTriggered: webview.goBackOrForward(model.offset)
            checkable: !enabled
            checked: !enabled
            enabled: model.offset    
        }

        onObjectAdded: function(index, object) {
            historyMenu.insertItem(index, object)
        }
        onObjectRemoved: function(index, object) {
            historyMenu.removeItem(object)
        }
    }
}
