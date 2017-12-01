object q5 {
    def main(args: Array[String]) {
        println(Range(20, Int.MaxValue)
            .find(n => Range(2, 21)
                .forall(n % _ == 0))
            .get)
    }
}
