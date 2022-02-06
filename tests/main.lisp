(defpackage twentyfour/tests/main
  (:use :cl
        :twentyfour
        :rove))
(in-package :twentyfour/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :twentyfour)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
