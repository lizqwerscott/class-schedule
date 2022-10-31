(defsystem "class-schedule"
  :version "0.1.0"
  :author "Lizqwer scott"
  :license ""
  :depends-on ("clack" "local-time" "yason" "jonathan" "str" "s-base64" "flexi-streams" "log4cl")
  :components ((:module "src"
                :components
                ((:file "head")
                 (:file "server")
                 (:file "schedule")
                 (:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "class-schedule/tests"))))

(defsystem "class-schedule/tests"
  :author "Lizqwer scott"
  :license ""
  :depends-on ("class-schedule"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for class-schedule"
  :perform (test-op (op c) (symbol-call :rove :run c)))
