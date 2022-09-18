(defpackage :class-schedule.head
  (:import-from :jonathan :to-json)
  (:use :common-lisp :clack :yason :babel)
  (:export
   :to-json-a
   :assoc-value
   :stream-recive-string))
(in-package :class-schedule.head)

(setf yason:*parse-object-as* :alist)

(defun to-json-a (alist)
  (to-json alist :from :alist))

(defun assoc-value (plist key)
  (cdr (assoc key plist :test #'string=)))

(defun stream-recive-string (stream length)
  (let ((result (make-array length :element-type '(unsigned-byte 8))))
    (read-sequence result stream)
    (format t "oct: ~A~%" result)
    (octets-to-string result :encoding :utf-8)))
