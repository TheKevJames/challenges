object q3 {
    def factors(n: Long): List[Long] =
        (2 to math.sqrt(n).toInt)
            .find(n % _ == 0)
            .map(i => i.toLong :: factors(n / i))
            .getOrElse(List(n))

    def main(args: Array[String]) {
        println(factors(600851475143L).last)
    }
}
