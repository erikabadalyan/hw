(define (accumulate combiner start n term)
  (if (= n 0)
  start
  (combiner (term n) (accumulate combiner start (- n 1) term) )
  )
)

(define (accumulate-tail combiner start n term)
(if (= n 0)
start
(accumulate-tail combiner (combiner (term n) start) (- n 1) term) )
)

(define (partial-sums stream)
  (define (helper total stream)

    (if (eq? stream ())
      ()
      (cons-stream (+ total (car stream)) (helper (+ total (car stream)) (cdr-stream stream)))
    )

  )

  (helper 0 stream)
)

(define (rle s)
  (define (helper node prev count)
    (if (null? node)
      (cons-stream (list prev count) nil)
      (if (= prev (car node))
        (helper (cdr-stream node) prev (+ count 1))
        (cons-stream (list prev count) (helper (cdr-stream node) (car node) 1))
      )
    )
  )
  (if (null? s)
    nil
    (helper (cdr-stream s) (car s) 1)
  )
)
