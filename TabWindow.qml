import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebEngine 1.8
import QtQuick.Controls 2.5
import QtQml 2.2
import QtQuick.Controls.Styles 1.4

Item {

    property WebEngineView currentwebview: webview

    function fixUrl(url)
    {
        if (url === "") return url
        if (url[0] === "/") return "file://"+url
        if (url.indexOf(":") < 0) {
            if (url.indexOf(".") < 0 || url.indexOf(" ")>=0)
                return "https://www.google.ru/search?newwindow=1&source=hp&ei=pxwNXqKHN6H2qwHuwLrQBg&q="+url
             else
                return "https://"+url
        }
        return url
    }

  Rectangle {

      id: topline
      anchors {

          top: parent.top
          right: parent.right
          left: parent.left
          bottomMargin: 5
      }
      height: 30
      color: "white"

      Button {
          id: backbutton
          anchors {

              verticalCenter: parent.verticalCenter
              left: parent.left
              leftMargin: 5
              rightMargin: 5
          }
          width: 25
          height: 25
          onClicked: webview.goBack()
          Image {
              id: backimage
              source: "qrc:/icons/back-arrow-inactive.png"
              anchors.fill: parent
          }
          enabled: webview.canGoBack
      }

      Button {
          id: nextbutton
          anchors {

              verticalCenter: parent.verticalCenter
              left: backbutton.right
              leftMargin: 5
              rightMargin: 5
          }
          width: 25
          height: 25
          onClicked: webview.goForward()
          Image {
              id: nextimage
              source: "qrc:/icons/next-arrow-inactive.png"
              anchors.fill: parent
          }
          enabled: webview.canGoForward
      }

      Button {
          id: reloadbutton
          anchors {

              verticalCenter: parent.verticalCenter
              left: nextbutton.right
              leftMargin: 5
              rightMargin: 5
          }
          width: 25
          height: 25
          onClicked: webview.reload()
          Image {
              id: reloadimage
              source: "qrc:/icons/reload-arrow.png"
              anchors.fill: parent
          }
          enabled: webview.loadProgress == 100
          visible: webview.loadProgress == 100
      }

      Button {
          id: stopbutton
          anchors {

              verticalCenter: parent.verticalCenter
              left: nextbutton.right
              leftMargin: 5
              rightMargin: 5
          }
          width: 25
          height: 25
          onClicked: webview.stop()
          Image {
              id: stopimage
              source: "qrc:/icons/stop-button.png"
              anchors.fill: parent
          }
          enabled: webview.loadProgress != 100
          visible: webview.loadProgress != 100
      }

      Button {
          id: homebutton
          anchors {

              verticalCenter: parent.verticalCenter
              left: stopbutton.right
              leftMargin: 5
              rightMargin: 5
          }
          width: 25
          height: 25
          onClicked: { webview.url = "https://www.google.ru/" }
          Image {
              id: homeimage
              source: "qrc:/icons/home-button-inactive.png"
              anchors.fill: parent
          }
          enabled: webview.url != "https://www.google.ru/"
          onEnabledChanged:
          {
              if(enabled)
                  homeimage.source = "qrc:/icons/home-button-active.png";
              else
                  homeimage.source = "qrc:/icons/home-button-inactive.png";
          }
      }

       Button {
          id: history
          enabled: (webview.canGoBack || webview.canGoForward)
          height: 25
          width: 25
          anchors.right: parent.right
          anchors.rightMargin: 5
          anchors.verticalCenter: parent.verticalCenter
          onClicked: historyMenu.popup()

          Image {
              id: menuimage
              source: "qrc:/icons/history-button-inactive.png"
              anchors.fill: parent
          }
          onEnabledChanged:
          {
              if(enabled)
                  menuimage.source = "qrc:/icons/history-button-active.png";
              else
                  menuimage.source = "qrc:/icons/history-button-inactive.png";
          }

          HistoryMenu { id: historyMenu }
      }

  Rectangle
  {
      id: textline
      anchors {

         verticalCenter: parent.verticalCenter
         left: homebutton.right
         right: history.left
         rightMargin: 5
         leftMargin: 5
      }

      height: 20
      color: "#D3D3D3"
      radius: 5
      clip: true

      Image {

          id: webimage
          anchors
          {
              left: parent.left
              leftMargin: 5
              rightMargin: 5
          }
          height: parent.height
          width: parent.height
          source: webview.icon
      }

   MouseArea {

        anchors {
             verticalCenter: parent.verticalCenter
             left: webimage.right
             right: parent.right
             leftMargin: 5
             rightMargin: 5
         }
        acceptedButtons: Qt.RightButton
        height: parent.height
        cursorShape: Qt.IBeamCursor
        clip: true

        TextInp {
             id: urltext
             anchors {
                 verticalCenter: parent.verticalCenter
                 left: parent.left
                 right: parent.right
             }
             style:
                 TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {width: urltext.width; height: urltext.height; color: "#D3D3D3"}
                  }
             /*onFocusChanged:
             {
                 if (activeFocus)
                 {
                     cursorPosition = length;
                     selectAll();
                 }
                 else
                     cursorPosition = 0;
             }*/
             activeFocusOnPress: true
             onActiveFocusChanged:
             {
                 if (activeFocus)
                 {
                     cursorPosition = length;
                     selectAll();
                 }
                 else
                     cursorPosition = 0;
             }
          }
        }
     }
   }

  BusyIndicator {

      id: indicator

      anchors
      {
          verticalCenter: parent.verticalCenter
          horizontalCenter: parent. horizontalCenter
      }

     running: webview.loadProgress != 100.0
  }

   ProgressBar {
        id: progressbar
        anchors
        {
          top: topline.bottom
          left: parent.left
          right: parent.right
        }
        height: 5
        value: webview.loadProgress * 0.01
    }

    WebEngineView {

            id: webview
            visible: true
            url: "https://www.google.ru/"
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                top: progressbar.bottom
            }
            zoomFactor: 0.75
            onContentsSizeChanged: { zoomFactor = 0.75 }    //баг зума в qml, сбрасывается, о баге даже написано на сайте багов qt creator
            onLoadingChanged: urltext.cursorPosition = 0

            onCanGoBackChanged:
            {
                if(canGoBack)
                    backimage.source = "qrc:/icons/back-arrow-active.png";
                else
                    backimage.source = "qrc:/icons/back-arrow-inactive.png";
            }

            onCanGoForwardChanged:
            {
                if(canGoForward)
                    nextimage.source = "qrc:/icons/next-arrow-active.png";
                else
                    nextimage.source = "qrc:/icons/next-arrow-inactive.png";
            }

            onNewViewRequested:
                function(request) {
                if (!request.userInitiated)
                    print("Warning: Blocked a popup window.");
                else
                    if (request.destination === WebEngineView.NewViewInTab)
                    {
                      var tab = tabs.createEmptyTab(webview.profile);
                      tabs.currentIndex = tabs.count - 1;
                      request.openIn(tab.item.currentwebview);
                    }
                    else
                        if (request.destination === WebEngineView.NewViewInBackgroundTab)
                        {
                           var backgroundTab = tabs.createEmptyTab(webview.profile);
                           request.openIn(backgroundTab.item.currentwebview);
                        }
                 }
        }
}
