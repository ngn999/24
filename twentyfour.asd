(cl:defpackage #:twentyfour-system
  (:use :cl :asdf))

(cl:in-package #:twentyfour-system)

(defsystem "twentyfour"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :build-operation "program-op"
  :entry-point "twentyfour::main"
  :in-order-to ((test-op (test-op "twentyfour/tests"))))

(defsystem "twentyfour/tests"
  :author ""
  :license ""
  :depends-on ("twentyfour"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for twentyfour"
  :perform (test-op (op c) (symbol-call :rove :run c)))
