(cl:defpackage twentyfour
  (:use :cl))
(cl:in-package :twentyfour)

;; 5, 5, 5, 1
(defun main()
  ""
  (format t "hello world!"))

;; TODO: 使用递归的思想, 降到3个数的问题, 再降到2个数的问题
;; TODO: 利用lisp宏的特性,生成所有的组合,求值后找出所有的可能

;; 6 5 4 1
;; 5 5 5 1: 5 * (5 - 1 / 5)
;; 用逆波兰表达式,输出结果.
(defun cal (target l)
  ;; (format t "~{~a~}~%" l)
  (if (= (length l) 1)
      ;; (if (= (car l) target)
      ;;     (format t "~{ ~a ~}~%" (if p
      ;;                                (cons (car l) result)
      ;;                                (append result (list (car l))))))
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
              (bediv `(,first ,@bediv  /)))
        )))

(defun all-permutations (list)
  (cond ((null list) nil)
        ((null (cdr list)) (list list))
        (t (loop for element in list
             append (mapcar #'(lambda (l) (cons element l))
                            (all-permutations (remove element list :count 1)))))))
(all-permutations '(5 5 5 1))

(mapcar #'(lambda (l)
            (let ((r (cal 24 l)))
              (if r (format t "~{ ~a ~}~%" r))))
        (all-permutations '(4 1 6 5)))

(mapcar #'(lambda (l)
            (let ((r (cal 24 l)))
              (if r (format t "~{ ~a ~}~%" r))))
        (all-permutations '(1 5 5 5)))

;; (format t "~{ ~a ~} ~%" (cal 24 '(26 1 1)))
;; (format t "~{ ~a ~} ~%" (cal 24 '(1 2 27)))
;; (format t "~{ ~a ~} ~%" (cal 24 '(48 2 1)))
;; (format t "~{ ~a ~} ~%" (cal 24 '(1 2 27)))
;; (format t "~{ ~a ~} ~%" (cal 24 '(5 5 1 5)))
;; (format t "~{ ~a ~} ~%" (cal 24 '(5 6 4 1)))
