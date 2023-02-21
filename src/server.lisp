(defpackage :class-schedule.server
  (:import-from :str :contains?)
  (:use :cl :class-schedule.head :clack :yason :log4cl :lzputils.json)
  (:export
   :server-start
   :server-stop
   :defroute))
(in-package :class-schedule.server)

(defparameter *routes*
  (make-hash-table :test #'equal))

(defparameter *clack-server* nil)

(defun defroute (path fn)
  (setf (gethash path *routes*)
        fn))

(defun handle-json (raw-body content-length route-fn)
  (let ((body (stream-recive-string raw-body
                                    content-length)))
    (if body
        (let ((data (parse body)))
          (funcall route-fn
                   data))
        (to-json-a
         `(("msg" . 200)
           ("result" . "data is null"))))))

(defun handler (env)
  ;; (format t "get env:~A~%" env)
  (destructuring-bind (&key request-method path-info request-uri query-string headers content-type content-length raw-body &allow-other-keys)
      env
    (let ((route-fn (gethash path-info *routes*)))
      (log-info path-info)
      (if route-fn
          (if (contains? "application/json"
                         content-type)
              `(200
                nil
                (,(handler-case
                      (handle-json raw-body
                                   content-length
                                   route-fn)
                    (error (c)
                      (format t "[ERROR]: ~A~%" c)
                      (format nil "error ~A" c)))))
              `(404
                nil
                (,(format nil "Only support json data."))))
          `(404
            nil
            (,(format nil "The Path not find~%")))))))

(defun server-start (&rest args &key server address port &allow-other-keys)
  (declare (ignore server address port))
  (when *clack-server*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (server-stop))))
  (setf *clack-server*
        (apply #'clackup #'handler args)))

(defun server-stop ()
  (if *clack-server*
      (progn
        (stop *clack-server*)
        (setf *clack-server* nil))
      (format t "not started!~%")))
