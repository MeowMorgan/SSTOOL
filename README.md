# Check Tool

A lightweight desktop forensics toolkit built for FiveM PC checkers. Downloads, organizes, and runs all the tools you need during a screenshare session — one click at a time.

Built with Python + pywebview. Ships as a single `.exe`, no installs required on the target machine.

![Python](https://img.shields.io/badge/Python-3.12-blue) ![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-green) ![License](https://img.shields.io/badge/License-MIT-yellow)

---

## What it does

Check Tool is basically a launcher that sits on your desktop and gives you quick access to everything you'd normally have to dig around for during a PC check. It downloads tools directly to a `Checker` folder on the desktop and can run PowerShell scripts and registry scans without leaving the app.

**Tool categories included:**

- **NirSoft Tools** — WinPrefetchView, WinDefThreatsView, USBDeview, Everything, LastActivityView, AlternateStreamView, TaskSchedulerView, BrowsingHistoryView, WinDefLogView
- **Detect AC Tools** — BAM Parser, Prefetch Parser, PcaSvc Executed, Process Parser
- **Eric Zimmerman's Tools** — AmCacheParser, Timeline Explorer, Bstrings, SrumECmd, AppCompatCacheParser, Registry Explorer, MfteCmd
- **Echo Tools** — String Scanner, USB Deview Viewer, Easy Journal Viewer, BAM Log Viewer, UserAssist Viewer
- **PowerShell Scripts** — Services check, Red Lotus BAM, Path Signature, Hard Disk Volume
- **Standalone tools** — Journal Trace, Disk Drill, Magnet Process Capture, Hayabusa, FTK Imager, OsForensics, System Informer

Each category has a "download all" button if you want to grab everything at once.

**Other features:**
- USB registry scan (checks 4 registry keys for evidence of USB device usage)
- PowerShell script execution with live output in the built-in terminal
- Auto-creates `Checker` folder on Desktop
- Shows connected username, hostname, and current status
- Real-time terminal log with color-coded output

---
<img width="1263" height="788" alt="Screenshot_1" src="https://github.com/user-attachments/assets/a6866e33-606c-4ba8-89ec-dc8140aa2e9a" />

---

## Requirements

**For development:**
- Python 3.12
- pywebview (`pip install pywebview`)

**For end users:**
- Just the `.exe` file. Nothing else needed.

---

## Running in dev mode

```bash
git clone https://github.com/yourusername/check-tool.git
cd check-tool
pip install pywebview
python app.py
```

The window should pop up and you're good to go. All downloads go to `C:\Users\<you>\Desktop\Checker\`.

---

## Building the .exe

Make sure you have Python 3.12 and PyInstaller:

```bash
pip install pywebview pyinstaller
```

Then build:

```bash
pyinstaller --onefile --noconsole --name "Checker" --icon "web\icon.ico" --add-data "web;web" app.py
```

Your standalone exe will be at `dist\Checker.exe` (~13MB). Send it to whoever needs it — it works out of the box on any Windows 10/11 machine.

> **Note:** If you're running multiple Python versions, use `py -3.12` instead of `python`.

---

## Project structure

```
check-tool/
├── app.py              # Python backend — handles downloads, registry, powershell
├── build.bat           # One-click build script
├── web/
│   ├── index.html      # Main UI
│   ├── style.css       # Styling (dark theme + red accents)
│   ├── app.js          # Frontend logic — tool data, menus, terminal
│   ├── icons.js        # SVG icon library
│   ├── bg.png          # Background image
│   ├── icon.ico        # App icon
│   └── icon.png        # App icon (png)
└── README.md
```

---

## How it works under the hood

The app uses [pywebview](https://pywebview.flowrl.com/) to render an HTML/CSS/JS interface inside a native window. The frontend talks to a Python backend through pywebview's JS-to-Python bridge (`pywebview.api`).

- **Downloads** are handled by Python's `urllib` with proper headers so sites like `dl.echo.ac` don't reject the requests
- **Registry scans** use `subprocess` to call `reg query` directly
- **PowerShell scripts** run via `subprocess` with `-ExecutionPolicy Bypass`
- **PyInstaller** bundles everything (Python runtime + web files + dependencies) into a single exe using `--onefile`

No Electron, no Node.js, no WebView2 dependency headaches. Just Python.

---

## Adding new tools

Open `web/app.js` and add entries to the relevant array. Each tool looks like this:

```javascript
{ 
  id: "n1", 
  name: "ToolName", 
  icon: "shield",        // icon name from icons.js
  category: "Category", 
  url: "https://...",     // direct download link
  filename: "Tool.zip"   // saved as this in Checker folder
}
```

For a new category, create a new array and add it to `MAIN_TOOLS` as a submenu:

```javascript
const MY_TOOLS = [
  { id:"m1", name:"My Tool", icon:"search", category:"Custom", url:"https://...", filename:"MyTool.exe" },
];

// In MAIN_TOOLS:
{ id:"15", name:"My Tools", icon:"shield", category:"Toolkit", submenu: MY_TOOLS },
```

---

## Credits

- Developed by [@napoli]





---

## License

MIT — do whatever you want with it.
