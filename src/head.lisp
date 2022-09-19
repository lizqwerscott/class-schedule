(defpackage :class-schedule.head
  (:import-from :jonathan :to-json)
  (:use :common-lisp :clack :yason :babel :s-base64 :local-time)
  (:export
   :to-json-a
   :assoc-value
   :stream-recive-string
   :get-data-dir
   :load-json-file
   :encode-str-base64
   :rc4-encrypt
   :time-unix-mill))
(in-package :class-schedule.head)

(setf yason:*parse-object-as* :alist)

(defun to-json-a (alist)
  (to-json alist :from :alist))

(defun assoc-value (plist key)
  (cdr (assoc key plist :test #'string=)))

(defun stream-recive-string (stream length)
  (let ((result (make-array length :element-type '(unsigned-byte 8))))
    (read-sequence result stream)
    (octets-to-string result :encoding :utf-8)))

(defun get-source-dir ()
  (asdf:system-source-directory :class-schedule))

(defun get-data-dir ()
  (merge-pathnames "datas/"
                   (get-source-dir)))

(defun load-json-file (path)
  (with-open-file (in path :direction :input :if-does-not-exist :error)
    (multiple-value-bind (s) (make-string (file-length in))
      (read-sequence s in)
      (parse s))))

(defun encode-str-base64 (str)
  (with-output-to-string (out)
    (encode-base64-bytes (string-to-octets str)
                         out)))

(defun convert-hex (n)
  (let ((res (format nil "~(~x~)" n)))
    (if (= 1 (length res))
        (format nil "0~A" res)
        (format nil "~A~A" (elt res (- (length res) 2))
                (elt res (- (length res) 1))))))

(defun char-to-octet (char)
  (elt (string-to-octets
        (format nil
                "~A"
                char))
       0))

(map 'array
     #'(lambda (x)
         (+ x 1))
     (make-array 3
                 :element-type '(unsigned-byte 8)
                 :initial-element 0))

(defun range-array (end &key (element-type '(unsigned-byte 8)))
  (let ((res (make-array end :element-type element-type)))
    (dotimes (i end)
      (setf (elt res
                 i)
            i))
    res))

(defun rc4-encrypt (src passwd)
  (let ((sbox (range-array 256))
        (key (make-array 256 :element-type '(unsigned-byte 8)))
        (plen (length passwd))
        (size (length src))
        (j 0)
        (temp nil)
        (a 0)
        (b 0)
        (output ""))
    (dotimes (i 256)
      (setf (elt key i)
            (char-to-octet
             (elt passwd
                  (mod i plen)))))
    (dotimes (i 256)
      (setf j
            (mod (+ j
                    (elt sbox i)
                    (elt key i))
                 256))
      (setf temp
            (elt sbox i))
      (setf (elt sbox i)
            (elt sbox j))
      (setf (elt sbox j)
            temp))
    (dotimes (i size)
      (setf a
            (mod (+ a 1)
                 256))
      (setf b
            (mod (+ b (elt sbox a))
                 256))
      (setf temp
            (elt sbox a))
      (setf (elt sbox a)
            (elt sbox b))
      (setf (elt sbox b)
            temp)
      (setf output
            (format nil
                    "~A~A"
                    output
                    (convert-hex
                     (logxor (char-to-octet (elt src i))
                             (elt sbox
                                  (mod (+ (elt sbox a)
                                          (elt sbox b))
                                       256)))))))
    output))

(defun time-unix-mill (timestamp)
  (+ (* 1000 (timestamp-to-unix timestamp))
     (timestamp-millisecond timestamp)))
