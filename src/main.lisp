(defpackage class-schedule
  (:use :cl :class-schedule.head :class-schedule.server)
  (:export
   :start-s
   :restart-s
   :stop-s))
(in-package :class-schedule)

(defroute "/"
    (lambda (x)
      (declare (ignore x))
      `(("msg" . 200)
        ("result" . "Helo"))))

(defroute "/todayclass"
    (lambda (x)
      (let ((person (assoc-value x "person")))
        `(("msg" . 200)
          ("result" . "1")))))

(defun start-s (&optional (port 8089))
  (server-start :address "0.0.0.0" :port port))

(defun restart-s (&optional (port 8089))
  (server-start :address "0.0.0.0" :port port))

(defun stop-s ()
  (server-stop))
