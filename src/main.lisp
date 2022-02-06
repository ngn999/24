(cl:defpackage twentyfour
  (:use :cl))
(cl:in-package :twentyfour)

(defun main()
  ""
  (opts:define-opts
    (:name :help
     :description "show this help message."
     :short #\h
     :long "help"))
  (multiple-value-bind (options free-args)
      (opts:get-opts)
    (if (getf options :help)
        (progn
          (opts:describe
           :prefix "twentyfour Usage: ./twentyfour 5 5 5 1")
          (uiop:quit)))
    (if (= 4 (length free-args))
        (format t "~{~a~%~}" (loop for r in (all-permutations (mapcar #'(lambda (x) (parse-integer x)) free-args))
                           for rpn = (cal 24 r)
                           when (not (null rpn))
                             collect rpn))
        (progn (opts:describe :prefix "twentyfour Usage: ./twentyfour 5 5 5 1")
               (uiop:quit)))))

;; TODO: 使用递归的思想, 降到3个数的问题, 再降到2个数的问题
;; TODO: 利用lisp宏的特性,生成所有的组合,求值后找出所有的可能

;; 6 5 4 1
;; 5 5 5 1: 5 * (5 - 1 / 5)
;; 用逆波兰表达式,输出结果.
(defun cal (target l)
  (if (null (cdr l))
      (if (= (car l) target)
          l
          nil)
      (let* ((rest (cdr l))
             (first (car l))
             (sum (cal (- target first) rest))
             (sub (cal (+ target first) rest))
             (besub (cal (- first target) rest))
             (mult (if (/= 0 first) (cal (/ target first) rest)))
             (div (cal (* target first) rest))
             (bediv (if (/= 0 target) (cal (/ first target) rest))))
        (cond (sum `(,first ,@sum +))
              (sub `(,@sub ,first -))
              (besub `(,first ,@besub  -))
              (mult `(,first ,@mult  *))
              (div `(,@div  ,first  /))
              (bediv `(,first ,@bediv  /))
              )
        )))

(defun eliminate-duplicates (l)
  (cond ((null l) l)
        ((member (car l) (cdr l))
         (eliminate-duplicates (cdr l)))
        (t (cons (car l) (eliminate-duplicates (cdr l))))))

(defun all-permutations (list)
    (cond ((null list) nil)
        ((null (cdr list)) (list list))
        (t (loop for element in (eliminate-duplicates list)
             append (mapcar #'(lambda (l) (cons element l))
                            (all-permutations (remove element list :count 1)))))))
