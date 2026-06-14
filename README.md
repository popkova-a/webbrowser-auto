# WebBrowser-Auto

A tabbed desktop web browser built in [QML](https://doc.qt.io/qt-5/qmlapplications.html) with the [Qt](https://www.qt.io/) framework, using Qt WebEngine for page rendering. Created with Qt Creator.

## Features

- **Tabbed browsing** — open multiple tabs with the `+` button; tabs are movable and titled by the current page.
- **Navigation controls** — back, forward, reload, and stop buttons that enable/disable based on page state, with active/inactive icons.
- **Home button** — jumps to the start page.
- **Smart address bar** — type a URL to navigate directly, or type a search term to run a Google search. Bare hostnames are automatically prefixed with `https://`, and local paths are opened as `file://`.
- **History menu** — browse and jump to previously visited pages in the current tab.
- **Loading feedback** — a busy indicator and progress bar show page load status.
- **Page favicon** displayed in the address bar.
- **Popup handling** — user-initiated popups open in new tabs; non-user-initiated popups are blocked.

## Tech Stack

- **Language:** QML + C++ (C++11)
- **Framework:** Qt 5 (Qt Quick / Qt WebEngine)
- **Build system:** qmake
- **IDE:** Qt Creator

## Project Structure

```
webbrowser-auto/
├── WebBrowser_auto.pro      # qmake project file
├── main.cpp                 # entry point — initializes WebEngine, loads main.qml
├── qml.qrc                  # Qt resource bundle (QML files + icons)
│
├── main.qml                 # top-level window + TabView with the "new tab" control
├── TabWindow.qml            # a single tab: toolbar, address bar, web view, progress bar
├── TabRectangle.qml         # custom tab appearance
├── TextInp.qml              # editable URL / search input field
├── HistoryMenu.qml          # navigation history popup menu
│
├── icons/                   # toolbar and application icons
│   ├── app-icon.png
│   ├── back-arrow-active.png
│   ├── back-arrow-inactive.png
│   ├── next-arrow-active.png
│   ├── next-arrow-inactive.png
│   ├── home-button-active.png
│   ├── home-button-inactive.png
│   ├── history-button-active.png
│   ├── history-button-inactive.png
│   ├── reload-arrow.png
│   └── stop-button.png
│
└── README.md
```

## Getting Started

### Prerequisites

- [Qt 5](https://www.qt.io/download) with the **Qt WebEngine** module and Qt Creator
- A C++ compiler (GCC, Clang, or MSVC)

> Qt WebEngine is required and is a separate component — make sure it is installed via the Qt Maintenance Tool if it isn't already.

### Build & Run

**Using Qt Creator:**

1. Clone the repository:
   ```bash
   git clone https://github.com/popkova-a/webbrowser-auto.git
   ```
2. Open `WebBrowser_auto.pro` in Qt Creator.
3. Configure a kit if prompted, then click **Run** (or press `Ctrl+R`).

**From the command line:**

```bash
git clone https://github.com/popkova-a/webbrowser-auto.git
cd webbrowser-auto
qmake WebBrowser_auto.pro
make
./WebBrowser_auto
```

## How It Works

`main.cpp` initializes Qt WebEngine and loads `main.qml`, which hosts a `TabView`. Each tab is an instance of `TabWindow.qml` containing a `WebEngineView` plus a toolbar. The address bar uses a `fixUrl()` helper to decide whether the input is a URL or a search query, then routes it accordingly. Navigation button states (enabled/disabled and their icons) are bound to the web view's `canGoBack`, `canGoForward`, and `loadProgress` properties so the UI updates automatically as pages load.

## License

This project was created for educational purposes as a university assignment.
