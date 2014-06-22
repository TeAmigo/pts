;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copyright (C) 2010, 2011-2012, 2014 Rick Charon.
;; Author:        Rick Charon <rickcharon@gmail.com>
;; Version:       1.0
;; File path:     /share/elisp/ptsprogs.el
;; Description:   
;; Created at:    Tue May 31 11:45:35 2011
;; Modified at:   Fri Jun 20 17:29:30 2014
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defgroup ptsprogs nil
  "This group consists of ptscharts and ptsupdater, both run java
programs for my trading <2011-02-03 Thu 18:13> Rick"
  :group 'applications)

(defvar ptscharts-buffer-name)

(defsubst ptscharts-add-to-window-buffer-names ()
  "Add `eshell-buffer-name' to `same-window-buffer-names'."
  (add-to-list 'same-window-buffer-names ptscharts-buffer-name))

(defsubst ptscharts-remove-from-window-buffer-names ()
  "Remove `ptscharts-buffer-name' from `same-window-buffer-names'."
  (setq same-window-buffer-names
        (delete ptscharts-buffer-name same-window-buffer-names)))

(defcustom ptscharts-buffer-name "*PtsCharts*"
  "The name for the buffer running PtsCharts."
  :set (lambda (symbol value)
	 ;; remove the old value of `ptscharts-buffer-name', if present
	 (if (boundp 'ptscharts-buffer-name)
	     (ptscharts-remove-from-window-buffer-names))
	 (set symbol value)
	 ;; add the new value
	 (ptscharts-add-to-window-buffer-names)
	 value)
  :type 'string
  :group 'ptsprogs)


(defcustom ptsupdater-input-file ""
  "Filename to use as input to ptsupdater."
  :type 'string
  :group 'ptsprogs)



(defvar ptsupdater-buffer-name)

(defsubst ptsupdater-add-to-window-buffer-names ()
  "Add `eshell-buffer-name' to `same-window-buffer-names'."
  (add-to-list 'same-window-buffer-names ptsupdater-buffer-name))

(defsubst ptsupdater-remove-from-window-buffer-names ()
  "Remove `ptsupdater-buffer-name' from `same-window-buffer-names'."
  (setq same-window-buffer-names
        (delete ptsupdater-buffer-name same-window-buffer-names)))


(defcustom ptsupdater-buffer-name "*PtsUpdater*"
  "The basename used for Eshell buffers."
  :set (lambda (symbol value)
	 ;; remove the old value of `ptsupdater-buffer-name', if present
	 (if (boundp 'ptsupdater-buffer-name)
	     (ptsupdater-remove-from-window-buffer-names))
	 (set symbol value)
	 ;; add the new value
	 (ptsupdater-add-to-window-buffer-names)
	 value)
  :type 'string
  :group 'ptsprogs)

(defun ptsgroovy(&optional arg)
  "<2014-05-12 Mon 16:42> Switch to pts directory, load the charting basics into groovy, and open
chartdriver in split window. With ARG runs in debug mode. Attach debugger on port 8000."
  (interactive "P")
  (cd "/share/pts")
  (find-file "/share/pts/ptschartsdriver.groovy")
  (if arg (run-groovy "groovydebug") (run-groovy "groovysh --color=false")))


(defun ptscharts-mvn(&optional arg)
  "<2014-05-18 Sun 13:00> BROKEN - Use ptsgroovy instead.
End up in a Groovy shell via Maven (mvn groovy:shell), or debug run (mvnDebug groovy:shell) with C-u.
If using mvnDebug, need to do in Netbeans: Debug/Attach Debugger, use socket attach, dt_socket for Tranport,
host ricks-studio, (could be localhost?), Port 8000."
  (interactive "P")
  (cd "/share/JavaDev/teamigo/ptscharts")
  (if arg (run-groovy "mvnDebug groovy:shell") (run-groovy "mvn groovy:shell"))
  (find-file-other-window "./ptschartsdriver.groovy"))
;;  (rename-buffer ptscharts-buffer-name)))


(defun ptsupdater ()
  "<2014-05-06 Tue 14:19> Updates all the trading data for contracts currently in Trading DB. (Currently
PostgresSQL DB trading). If you want to pass a file of symbols to update, (see csv files in /share/JavaDev/teamigo/ptsupdater), stop it's execution, and restart it pasting the filename in."
  (interactive)
  (require 'eshell)
  (cd "/share/pts/ptsupdater")
  (let ((buf (get-buffer-create "*PtsUpdater*")))
    ;; Simply calling `pop-to-buffer' will not mimic the way that
    ;; shell-mode buffers appear, since they always reuse the same
    ;; window that that command was invoked from.  To achieve this,
    ;; it's necessary to add the buffer name to the variable
    ;; `same-window-buffer-names', which is done when ? is loaded
    (assert (and buf (buffer-live-p buf)))
    (pop-to-buffer buf)
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode)))
  (end-of-buffer)
  (eshell-kill-input)
  ;;(insert (concat "java -jar /share/pts/ptsupdater/build/libs/ptsupdater-1.5-SNAPSHOT.jar" " " ptsupdater-input-file))
  (insert "gradle run")
  (eshell-send-input)
  (end-of-buffer))

(defun ptscharts ()
  "<2014-05-06 Tue 14:19> Updates all the trading data for contracts currently in Trading DB. (Currently
PostgresSQL DB trading). If you want to pass a file of symbols to update, (see csv files in /share/JavaDev/teamigo/ptsupdater), stop it's execution, and restart it pasting the filename in."
  (interactive)
  (require 'eshell)
  (cd "/share/pts/ptscharts")
  (let ((buf (get-buffer-create "*PtsCharts*")))
    ;; Simply calling `pop-to-buffer' will not mimic the way that
    ;; shell-mode buffers appear, since they always reuse the same
    ;; window that that command was invoked from.  To achieve this,
    ;; it's necessary to add the buffer name to the variable
    ;; `same-window-buffer-names', which is done when ? is loaded
    (assert (and buf (buffer-live-p buf)))
    (pop-to-buffer buf)
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode)))
  (end-of-buffer)
  (eshell-kill-input)
  (insert "gradle run")
  (eshell-send-input)
  (end-of-buffer))

(defun ptscontractinfos ()
  (interactive)
  (require 'eshell)
  (let ((buf (get-buffer-create "*PtsContractInfos*")))
    ;; Simply calling `pop-to-buffer' will not mimic the way that
    ;; shell-mode buffers appear, since they always reuse the same
    ;; window that that command was invoked from.  To achieve this,
    ;; it's necessary to add the buffer name to the variable
    ;; `same-window-buffer-names', which is done when ? is loaded
    (assert (and buf (buffer-live-p buf)))
    (pop-to-buffer buf)
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode)))
  (end-of-buffer)
  (eshell-kill-input)
  ;; (insert "java -jar /share/JavaDev/ptsupdater/dist/ptsupdater.jar")
  (insert "java -jar /share/JavaDev/teamigo/ptscontractinfos/target/ptscontractinfos-1.3-SNAPSHOT.jar")
  (eshell-send-input)
  (end-of-buffer))

;;   "<2014-05-06 Tue 14:24> The file of symbols being used is hard-coded as an argument to the program. It is
;; /share/JavaDev/teamigo/ptscontractinfos/contracts.csv. Stop execution and restart with arg to get a dialog box for entering a
;; single symbol"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File path:     /share/elisp/ptsprogs.el
;; Version:       
;; Description:   Run the Perfect Trader System programs in Eshell buffer
;;                PtsCharts ->     java -jar /share/JavaDev/ptscharts/dist/ptscharts.jar
;;                PtsUpdater ->    java -jar /share/JavaDev/ptsupdater/dist/ptsupdater.jar
;; Author:        Rick Charon <rickcharon@gmail.com>
;; Created at:    Thu Jan 20 15:01:31 2011
;; Modified at:   Tue May 31 11:45:35 2011
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
