object q2 {
    def main(args: Array[String]) {
        lazy val fib: Stream[Int] = 0 #:: fib.scanLeft(1)(_ + _)
        println(fib
            .takeWhile(_ <= 4000000)
            .filter(_ % 2 == 0)
            .sum)
    }
}
