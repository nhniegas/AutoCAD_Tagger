AutoCAD/ZWCAD Auto-Tagger Tool
A streamlined background tagging utility for MText entities. This tool automates the process of sequential numbering and lettering for technical drawings.

🛠 Prerequisites
OpenDCL Runtime: This tool requires the OpenDCL engine to be installed on your system.

Download OpenDCL Runtime

AutoCAD: Compatible with most modern versions.

🚀 Installation & Setup
Download Files: Ensure main.lsp and BT.odcl are in the same folder.

Configure Support Path:

Open Options > Files tab.

Add your folder to the Support File Search Path.

Load Script:

Type APPLOAD in the command line.

Add main.lsp to the Startup Suite (briefcase icon) to load it automatically every time you open a drawing.

⌨️ How to Use
Launch: Type BT to open the tagging interface.

Setup: Choose your prefix, starting number, and letter.

Note: Letters 'I' and 'O' are excluded to prevent confusion with numbers 1 and 0.

Activate: Type "ACTV" to start the background loop. 

Tag: Simply click on any MText entity in your drawing. The tool will update the text and automatically increment the number for you.

Stop: Hit ESC to end the tagging session.

⚠️ Troubleshooting
Command returns nil: Ensure the .lsp file is fully loaded and you haven't renamed functions manually.

"Can't reenter LISP": Make sure the "Keep Focus" property is set to False in OpenDCL Studio.
