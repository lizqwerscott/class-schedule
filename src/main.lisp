(defpackage class-schedule
  (:use :cl :class-schedule.head :class-schedule.server :local-time :str)
  (:export
   :start-s
   :restart-s
   :stop-s))
(in-package :class-schedule)

(defun load-class-person (path)
  (load-json-file path))

(defparameter +person-class+
  (load-class-person
   (merge-pathnames "class.json"
                    (get-data-dir))))

(defun search-person-class (person)
  (car
   (find person
         (assoc-value +person-class+ "class")
         :key #'(lambda (x)
                  (car (cdr (car (cdr x)))))
         :test #'string=)))

(defun load-class-schedule (class)
  (let ((path (merge-pathnames (format nil "classSchedule/~A.json" class)
                               (get-data-dir))))
    (when (probe-file path)
      (load-json-file path))))

(defun probe-week-s ()
  (let ((day-week (truncate
                   (/ (- (timestamp-to-universal
                          (today))
                         (timestamp-to-universal
                          (encode-timestamp 0 0 0 8 12 9 2022)))
                      (* 3600 24)
                      7))))
    (if (= 0
           (mod day-week
                2))
        "signal"
        "double")))

(defun get-week-class-schedule (class-schedule &optional (week (timestamp-day-of-week (today))))
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
                                                              "weeks"))))
                                (format nil "~A ~A ~A ~A"
                                        (assoc-value data "name")
                                        (assoc-value first-week "room")
                                        (assoc-value first-week "teacher")
                                        (assoc-value first-week "week")))
                              "没课!"))))
            (elt class-schedule (- week 1))
            (list "第一节" "第二节" "第三节" "第四节"))))

(defun get-class-schedule (person &optional (week (timestamp-day-of-week (today))))
  (get-week-class-schedule (load-class-schedule
                            (search-person-class person))
                           week))

(defroute "/"
    (lambda (x)
      (declare (ignore x))
      `(("msg" . 200)
        ("result" . "Hello"))))

(defroute "/todayclass"
    (lambda (x)
      (let ((schedule (search-person-class
                       (assoc-value x "person")))
            (jsonp (assoc-value x "jsonp")))
        (if schedule
            (let ((data (load-class-schedule schedule)))
              (if jsonp
                  (to-json-a
                   `(("msg" . 200)
                     ("result" . ,(get-week-class-schedule data))))
                  (let ((res (get-week-class-schedule data)))
                    (if res
                        (encode-str-base64 (join "\n" res))
                        (encode-str-base64 "没课！")))))
            `(("msg" . 404)
              ("result" . "not have class schedule"))))))

(defun generate-today-time (hour minute)
  (let ((now-time (today)))
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

(defun test ()
  (now-class (mapcar #'(lambda (x a)
                         (list x a))
                     (list "1" "2" "3" "4")
                     (generate-all-time))))

(defroute "/nowclass"
    (lambda (x)
      (let ((schedule (search-person-class
                       (assoc-value x "person")))
            (jsonp (assoc-value x "jsonp")))
        (if schedule
            (let* ((data (load-class-schedule schedule))
                   (res (get-week-class-schedule data)))
              (if res
                  (let ((now-time-class (now-class
                                         (mapcar #'(lambda (x t)
                                                     (list x t))
                                                 res
                                                 (generate-all-time)))))
                    (if jsonp
                        (to-json-a
                         `(("msg" . 200)
                           ("result" . ,now-time-class)))
                        (encode-str-base64 now-time-class)))
                  (if jsonp
                      (to-json-a
                         `(("msg" . 200)
                           ("result" . ,res)))
                      (encode-str-base64 "今天没课呢！"))))
            `(("msg" . 404)
              ("result" . "not have class schedule"))))))

(defun start-s (&optional (port 8089))
  (server-start :address "0.0.0.0" :port port))

(defun restart-s (&optional (port 8089))
  (server-start :address "0.0.0.0" :port port))

(defun stop-s ()
  (server-stop))
