;; Global toggle to control the loop
(setq is_tagging_active nil)

(defun c:BT (/)
  ;; 1. Load the OpenDCL engine using the command-based method (No ARX)
  (if (not (member "opendcl.arx" (arx)))
    (progn
      (command "OPENDCL")
      ;; Brief pause to allow the engine to initialize
      (while (< (getvar "CMDACTIVE") 0) (command))
    )
  )

  ;; 2. Find and Load the physical file
  (if (setq odcl_path (findfile "BT.odcl"))
    (progn
      ;; Forces the project into memory
      (dcl-Project-Load odcl_path T)
      
      ;; 3. Show the Form using Strings
      ;; This ignores the fact that !BT/window is nil in your command line
      (if (null (dcl-Form-Show window))
        (alert "Internal Error:\nProject 'BT' loaded, but form 'window' not found.\nCheck VarName in Studio.")
      )
    )
    (alert "Error: BT.odcl file not found!")
  )
  (princ)
)

;; This name must match: c: + [Form VarName] + /OnInitialize
(defun c:window#OnInitialize (/)
  
  ;; 1. Populate the 'number' ComboBox (1 to 100)
(dcl-ComboBox-Clear number)
  (setq n 1)

  (repeat 100
    (dcl-ComboBox-AddString number (itoa n))
    (setq n (1+ n))
  )
  ;; Set default starting number
  (dcl-Control-SetText number "1")

  ;; 2. Populate the 'letter' ComboBox (-, A to Z)
  (dcl-ComboBox-Clear letter)
  (dcl-ComboBox-AddString letter "-") ;; First option is a dash
  (dcl-Control-SetText letter "-") ;; Set default to dash 
  (setq char 65) ;; ASCII code for 'A'
  (repeat 26
    (if (and (/= char 73) (/= char 79))
      (dcl-ComboBox-AddString letter (chr char))
    )
    (setq char (1+ char))
  )
  ;; Set default starting letter
  
  (princ)
)

(defun c:ACTV (/)
  (if (not is_tagging_active)
    (progn
      ;; Start the loop
      (setq is_tagging_active T)
      (RunBackgroundTagging)
    )
    (progn
      ;; Stop the loop
      (setq is_tagging_active nil)
    )
  )
)

(defun RunBackgroundTagging (/ ent data pref num sub fullTag currentIdx olderr)
  
  ;; 1. Define what happens on ESCAPE
  (setq olderr *error*)
  (defun *error* (msg)
    (setq is_tagging_active nil)
    (setq *error* olderr)
    (princ (strcat "\nError: " msg))
    (princ)
  )

  (while is_tagging_active

    ;; 2. Wrapped selection
    (setq ent (entsel "\nTagging Active: Select MText (or click STOP): "))

    (if (and is_tagging_active ent)
      (progn
        (setq pref (dcl-Control-GetText name))
        (setq num  (dcl-Control-GetText number))
        (setq sub  (dcl-Control-GetText letter))
        (setq fullTag (strcat pref "-" num (if (= sub "-") "" sub)))
        
        (setq data (entget (car ent)))
        (if (= (cdr (assoc 0 data)) "MTEXT")
          (progn
            (entmod (subst (cons 1 fullTag) (assoc 1 data) data))
            (setq currentIdx (dcl-ComboBox-GetCurSel letter))
            (dcl-ComboBox-SetCurSel letter (1+ currentIdx))
          )
        )
      )
      ;; 3. If STOP button was clicked, loop ends naturally
      (setq is_tagging_active nil)
    )
  )

  ;; 4. Restore standard error handling
  (setq *error* olderr)
  (princ)
)

(defun c:number#OnEditChanged (NewValue /)
  ;; 0 is the first index in the list (the "-")
  (dcl-ComboBox-SetCurSel letter 0)
  (princ)
)

(defun c:number#OnSelChanged (ItemIndexOrCount Value /)
  ;; 0 is the first index in the list (the "-")
  (dcl-ComboBox-SetCurSel letter 0)
  (princ)
)
  
(defun c:name#OnEditChanged (NewValue /)
  (dcl-ComboBox-SetCurSel number 0)
  (dcl-ComboBox-SetCurSel letter 0)
  (princ)
)
