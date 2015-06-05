(def fib (lazy-cat [0 1]
                   (map + fib (rest fib))))

(println (reduce + (take-while (partial >= 4000000)
                               (filter even? fib))))
