(defpackage 24/tests/main
  (:use :cl
        :24
        :rove))
(in-package :24/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :24)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
