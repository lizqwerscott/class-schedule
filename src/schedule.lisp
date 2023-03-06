(defpackage :class-schedule.schedule
  (:use :common-lisp :class-schedule.head :local-time :str :lzputils.json)
  (:export
   :search-person-class
   :get-all-class-schedule
   :get-week-class-schedule

   :get-tomorrow-class

   :now-class
   :generate-all-time))
(in-package :class-schedule.schedule)

(defun load-class-person (path)
  (load-json-file path))

(defparameter +person-class+
  (load-class-person
   (merge-pathnames "class.json"
                    (get-data-dir))))

(defun get-start-week ()
  (apply #'encode-timestamp
         (append (list 0 0 0 8)
                 (mapcar #'parse-integer
                         (reverse
                          (split "."
                                 (assoc-value +person-class+
                                              "week-start")))))))

(defun search-person-class (person &optional (class (assoc-value +person-class+ "class")))
  (when class
    (let ((res (find person
                     (assoc-value (cdr (car class))
                                  "person")
                     :test #'string=)))
      (if res
          (car (car class))
          (search-person-class person (cdr class))))))

(defun get-all-class-name ()
  (mapcar #'(lambda (x)
              (car x))
          (assoc-value +person-class+
                       "class")))

(defun load-class-schedule (class)
  (let ((path (merge-pathnames (format nil "classSchedule/~A.json" class)
                               (get-data-dir))))
    (when (probe-file path)
      (load-json-file path))))

(defparameter +class-schedules+
  (make-hash-table :test #'equal))

(defun load-all-class-schedule ()
  (mapcar #'(lambda (class)
              (setf (gethash class
                             +class-schedules+)
                    (load-class-schedule class)))
          (get-all-class-name)))

(load-all-class-schedule)

(defun get-all-class-schedule (class)
  (gethash class
           +class-schedules+))

(defun probe-week-s ()
  (let ((day-week (truncate
                   (/ (- (timestamp-to-universal
                          (now-today))
                         (timestamp-to-universal
                          (get-start-week)))
                      (* 3600 24)
                      7))))
    (if (= 0
           (mod day-week
                2))
        "signal"
        "double")))

(defun handle-name (name-str)
  (let ((res (split "("
                    name-str)))
    (list (car res)
          (car (split ")"
                      (second res))))))

(defun get-week-class-schedule (class-schedule &optional (week (timestamp-day-of-week (now-today))))
  (when (and (<= week 5)
             (> week 0))
    (mapcar #'(lambda (class i)
                (let ((data (assoc-value class
                                         (probe-week-s))))
                  (format nil "~A ~A"
                          i
                          (if (listp data)
                              (let ((first-week (car
                                                 (assoc-value data
                                                              "weeks")))
                                    (name-and-id (handle-name
                                                  (assoc-value data
                                                               "name"))))
                                (format nil "~A ~A ~A ~A"
                                        (car name-and-id)
                                        (assoc-value first-week "room")
                                        (assoc-value first-week "teacher")
                                        (assoc-value first-week "week")))
                              "没课!"))))
            (elt class-schedule (- week 1))
            (list "第一节" "第二节" "第三节" "第四节"))))


(defun get-class-schedule (person &optional (week (timestamp-day-of-week (now-today))))
  (get-week-class-schedule (get-all-class-schedule
                            (search-person-class person))
                           week))

(defun get-tomorrow-class (class-schedule)
  (get-week-class-schedule class-schedule
                           (increase-week
                            (timestamp-day-of-week
                             (now-today)))))

(defun generate-today-time (hour minute)
  (let ((now-time (now-today)))
    (encode-timestamp 0 0 minute hour
                      (timestamp-day now-time)
                      (timestamp-month now-time)
                      (timestamp-year now-time))))

(defun generate-all-time ()
  (list (generate-today-time 8 10)
        (generate-today-time 10 20)
        (generate-today-time 14 0)
        (generate-today-time 16 0)))

(defun now-class (schedule-t)
  (if schedule-t
      (if (timestamp> (now)
                      (second
                       (car schedule-t)))
          (now-class (cdr schedule-t))
          (car (car schedule-t)))
      "没课了！"))
