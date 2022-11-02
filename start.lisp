(ql:quickload :class-schedule)

(class-schedule:start-s)

(do ((i 1 (+ i 1)))
    (nil i)
  (sleep 1))
