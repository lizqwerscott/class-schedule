(defpackage class-schedule/tests/main
  (:use :cl
        :class-schedule
        :rove))
(in-package :class-schedule/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :class-schedule)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
