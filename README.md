# 🏷️ AutoCAD Auto-Tagger Tool

A streamlined background tagging utility for MText entities. This tool automates the process of sequential numbering and lettering for technical drawings, ensuring accuracy and speed.

## 🛠️ Prerequisites

* **OpenDCL Runtime**: This tool requires the OpenDCL engine to be installed on your system to render the user interface.
    * [Download OpenDCL Runtime (v9.1.5.2)](https://sourceforge.net/projects/opendcl/files/Stable/OpenDCL.Studio.ENU.9.1.5.2.msi/download)
* **AutoCAD / ZWCAD**: Compatible with modern versions that support AutoLISP and OpenDCL.

## 🚀 Installation & Setup

1.  **Download Files**: Ensure `main.lsp` and `BT.odcl` are saved in the same folder.
2.  **Configure Support Path**:
    * Open **Options** > **Files** tab.
    * Add your folder to the **Support File Search Path**.
3.  **Load the Script**:
    * Type `APPLOAD` in the command line.
    * Add `main.lsp` to the **Startup Suite** (briefcase icon) to load it automatically every time you open a drawing.

## ⌨️ How to Use

1.  **Launch**: Type `BT` in the command line to open the tagging window.
2.  **Configure**: Choose your Prefix, Starting Number, and Letter.
    * *Note: Letters 'I' and 'O' are automatically excluded to prevent confusion with numbers '1' and '0'.*
3.  **Activate**: Type **ACTV** to start the background tagging loop.
4.  **Tag**: Click on any **MText** entity in your drawing. The tool will update the text and automatically increment the number for you.
5.  **Stop**: Hit **ESC** to end the tagging session.

## 🔧 Features

* **Dynamic Numbering**: Automatically increments numbers after each successful tag.
* **Smart Letter Reset**: Selecting a new number automatically resets the letter index to `-`.
* **Error Handling**: The background loop is designed to survive **ESC** key presses without crashing the command.
* **Filtered Lists**: Dropdowns are filtered for technical drawing standards (Excludes I, O).

## ⚠️ Troubleshooting

* **Command returns `nil`**: This usually means a syntax error prevented the script from loading. Ensure no invalid commands like `break` are in the code.
* **"Can't reenter LISP"**: This occurs if the OpenDCL Form is trying to take focus during an active selection. Ensure `Keep Focus` is set to `False` in the Studio project.

---
*Developed for efficient CAD workflows.*
