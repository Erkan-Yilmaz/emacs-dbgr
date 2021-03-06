(require 'test-unit)
(load-file "../dbgr/common/buffer/command.el")
(load-file "../dbgr/debugger/trepan/init.el")

(test-unit-clear-contexts)

(context "dbgr-buf-cmd"
	 (tag dbgr-buf-cmd)
	 (specify "dbgr-cmdbuf? before init"
		  (assert-nil (dbgr-cmdbuf? (current-buffer))))

	 (specify "dbgr-cmdbuf-command-string - uninit"
	 	  (assert-equal nil (dbgr-cmdbuf-command-string (current-buffer))))
	 (specify "dbgr-cmdbuf-init"
		  (setq temp-cmdbuf (generate-new-buffer "*cmdbuf-test*"))
		  (assert-t (dbgr-cmdbuf-init temp-cmdbuf "trepan" (gethash "trepan" dbgr-pat-hash)))
		  (with-current-buffer temp-cmdbuf
 		    (dbgr-cmdbuf-info-cmd-args= '("command" "args"))
		    (assert-equal "command args" 
				  (dbgr-cmdbuf-command-string temp-cmdbuf))
		    (assert-equal "trepan" 
				  (dbgr-cmdbuf-debugger-name))
		    (assert-equal nil 
				  (dbgr-cmdbuf-info-srcbuf-list 
				   dbgr-cmdbuf-info)
				  "srcbuf-list should start out nil")
		    (dbgr-cmdbuf-add-srcbuf (current-buffer) temp-cmdbuf)
		    (assert-equal (list (current-buffer))
				  (dbgr-cmdbuf-info-srcbuf-list
				   dbgr-cmdbuf-info)
				  "should have added one item to srcbuf-list")
		    (dbgr-cmdbuf-add-srcbuf (current-buffer) temp-cmdbuf)
		    (assert-equal (list (current-buffer))
				  (dbgr-cmdbuf-info-srcbuf-list
				   dbgr-cmdbuf-info)
				  "Second source buffer same as first; should have added still only one item.")

		   ))
	 )

(test-unit "dbgr-buf-cmd")

