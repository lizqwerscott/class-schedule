(defpackage class-schedule
  (:use :cl :class-schedule.head :class-schedule.server :class-schedule.schedule :local-time :str :babel)
  (:export
   :start-s
   :restart-s
   :stop-s))
(in-package :class-schedule)

(defun generate-json (data &optional (is-ok 200))
  (to-json-a
   `(("msg" . ,(if is-ok
                   200
                   400))
     ("result" . ,data))))

(defun return-json-or-txt (data jsonp &optional (data-nil "没课!"))
  (if jsonp
      (generate-json data)
      (encode-str-base64
       (if data
           (join "\n"
                 data)
           data-nil))))

(defroute "/"
    (lambda (x)
      (declare (ignore x))
      (generate-json "Hello")))

(defroute "/todayclass"
    (lambda (x)
      (let ((schedule (search-person-class
                       (assoc-value x "person")))
            (jsonp (assoc-value x "jsonp")))
        (if schedule
            (let ((data (get-all-class-schedule schedule)))
              (return-json-or-txt (get-week-class-schedule data)
                                  jsonp))
            (generate-json "not have class schedule"
                           nil)))))

(defroute "/nowclass"
    (lambda (x)
      (let ((schedule (search-person-class
                       (assoc-value x "person")))
            (jsonp (assoc-value x "jsonp")))
        (if schedule
            (let* ((data (get-all-class-schedule schedule))
                   (res (get-week-class-schedule data)))
              (if res
                  (let ((now-time-class (now-class
                                         (mapcar #'(lambda (x a)
                                                     (list x a))
                                                 res
                                                 (generate-all-time)))))
                    (if (string= now-time-class
                                 "没课了！")
                        (let ((tomorrow-class (get-tomorrow-class data)))
                          (return-json-or-txt (car tomorrow-class)
                                              jsonp
                                              "明天第一节没课!"))
                        (return-json-or-txt now-time-class
                                            jsonp)))
                  (return-json-or-txt res
                                      jsonp
                                      "今天没课呢！")))
            (generate-json "not have class schedule"
                           nil)))))

(defroute "/tomorrowclass"
  #'(lambda (x)
      (let ((schedule (search-person-class
                       (assoc-value x "person")))
            (jsonp (assoc-value x "jsonp")))
        (if schedule
            (let* ((data (get-all-class-schedule schedule))
                   (res (get-tomorrow-class data)))
              (return-json-or-txt res
                                  jsonp
                                  "明天没课呢!"))
            (generate-json "not have class schedule"
                           nil)))))

(defroute "/rc4encrypt"
    (lambda (x)
      (let ((src (assoc-value x "src"))
            (passwd (assoc-value x "passwd"))
            (jsonp (assoc-value x "jsonp")))
        (if (and src passwd)
            (let ((res (rc4-encrypt src passwd)))
              (if jsonp
                  (generate-json res)
                  res))
            (generate-json "参数错误"
                           nil)))))

(defun test ()
  (rc4-encrypt "12138"
               "1663679261299"))

(defroute "/timeencrypt"
    (lambda (x)
      (let ((pwd (assoc-value x "pwd"))
            (jsonp (assoc-value x "jsonp")))
        (let* ((now-time (format nil
                                 "~A"
                                 (time-unix-mill
                                  (now))))
               (res (rc4-encrypt pwd
                                 now-time)))
          (if jsonp
              (to-json-a
               `(("msg" . 200)
                 ("result" . (("res" . ,res)
                              ("time" . ,now-time)))))
              res)))))

(defun start-s (&optional (port 8089))
  (server-start :address "0.0.0.0" :port port :server :woo))

(defun restart-s (&optional (port 8089))
  (server-start :address "0.0.0.0" :port port :server :woo))

(defun stop-s ()
  (server-stop))
