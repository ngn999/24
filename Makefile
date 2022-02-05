LISP ?= sbcl

build:
	$(LISP) --load twentyfour.asd \
		--eval '(ql:quickload :twentyfour)' \
		--eval '(asdf:make :twentyfour)' \
		--eval '(quit)'

test:
	$(LISP) --load twentyfour.asd \
		--eval '(ql:quickload :twentyfour)' \
		--eval '(asdf:test-system :twentyfour)' \
		--eval '(quit)'

clean:
	$(RM) twentyfour
