(require '[clojure.string :as str])

; http://adventofcode.com/2016/day/2
(def data ["LLRRLLRLDDUURLLRDUUUDULUDLUULDRDDDULLLRDDLLLRRDDRRUDDURDURLRDDULRRRLLULLULLRUULDLDDDUUURRRRURURDUDLLRRLDLLRRDRDLLLDDRRLUDDLDDLRDRDRDDRUDDRUUURLDUDRRLULLLDRDRRDLLRRLDLDRRRRLURLLURLRDLLRUDDRLRDRRURLDULURDLUUDURLDRURDRDLULLLLDUDRLLURRLRURUURDRRRULLRULLDRRDDDULDURDRDDRDUDUDRURRRRUUURRDUUDUDDDLRRUUDDUUDDDUDLDRDLRDUULLRUUDRRRDURLDDDLDLUULUDLLRDUDDDDLDURRRDRLLRUUUUDRLULLUUDRLLRDLURLURUDURULUDULUDURUDDULDLDLRRUUDRDDDRLLRRRRLDRRRD"
           "DRRRDULLRURUDRLRDLRULRRLRLDLUDLUURUUURURULRLRUDRURRRLLUDRLLDUDULLUUDLLUUUDDRLRUDDDDLDDUUDULDRRRDULUULDULDRUUULRUDDDUDRRLRLUDDURLLDRLUDUDURUUDRLUURRLUUUDUURUDURLUUUDRDRRRDRDRULLUURURDLUULLDUULUUDULLLDURLUDRURULDLDLRDRLRLUURDDRLDDLRRURUDLUDDDLDRLULLDRLLLURULLUURLUDDURRDDLDDDDRDUUULURDLUUULRRLRDLDRDDDRLLRUDULRRRUDRRLDRRUULUDDLLDUDDRLRRDLDDULLLRDURRURLLULURRLUULULRDLULLUUULRRRLRUDLRUUDDRLLLLLLLURLDRRUURLDULDLDDRLLLRDLLLDLRUUDRURDRDLUULDDRLLRRURRDULLULURRDULRUDUDRLUUDDDDUULDDDUUDURLRUDDULDDDDRUULUUDLUDDRDRD"
           "RRRULLRULDRDLDUDRRDULLRLUUDLULLRUULULURDDDLLLULRURLLURUDLRDLURRRLRLDLLRRURUDLDLRULDDULLLUUDLDULLDRDLRUULDRLURRRRUDDLUDLDDRUDDUULLRLUUDLUDUDRLRUULURUDULDLUUDDRLLUUURRURUDDRURDLDRRDRULRRRRUUUDRDLUUDDDUDRLRLDRRRRUDDRLLRDRLUDRURDULUUURUULLRDUUULRULRULLRULRLUDUDDULURDDLLURRRULDRULDUUDDULDULDRLRUULDRDLDUDRDUDLURLLURRDLLDULLDRULDLLRDULLRURRDULUDLULRRUDDULRLDLDLLLDUDLURURRLUDRRURLDDURULDURRDUDUURURULLLUDDLDURURRURDDDRRDRURRUURRLDDLRRLDDULRLLLDDUDRULUULLULUULDRLURRRLRRRLDRRLULRLRLURDUULDDUDLLLUURRRLDLUDRLLLRRUU"
           "URLDDDLDRDDDURRRLURRRRLULURLDDUDRDUDDLURURLLRDURDDRLRUURLDLLRDLRUUURLRLDLDRUDDDULLDULLDUULURLDRDUDRRLRRLULRDDULUDULDULLULDLRRLRRLLULRULDLLDULRRLDURRRRDLURDLUDUUUDLURRRRRUDDUDUUDULDLURRDRLRLUDUDUUDULDDURUDDRDRUDLRRUDRULDULRDRLDRUDRLLRUUDDRLURURDRRLRURULLDUUDRDLULRUULUDURRULLRLUUUUUDULRLUUDRDUUULLULUDUDDLLRRLDURRDDDLUDLUUDULUUULDLLLLUUDURRUDUDLULDRRRULLLURDURDDLRRULURUDURULRDRULLRURURRUDUULRULUUDDUDDUURLRLURRRRDLULRRLDRRDURUDURULULLRUURLLDRDRURLLLUUURUUDDDLDURRLLUUUUURLLDUDLRURUUUDLRLRRLRLDURURRURLULDLRDLUDDULLDUDLULLUUUDLRLDUURRR"
           "RLLDRDURRUDULLURLRLLURUDDLULUULRRRDRLULDDRLUDRDURLUULDUDDDDDUDDDDLDUDRDRRLRLRLURDURRURDLURDURRUUULULLUURDLURDUURRDLDLDDUURDDURLDDDRUURLDURRURULURLRRLUDDUDDDLLULUDUUUDRULLLLULLRDDRDLRDRRDRRDLDLDDUURRRDDULRUUURUDRDDLRLRLRRDLDRDLLDRRDLLUULUDLLUDUUDRDLURRRRULDRDRUDULRLLLLRRULDLDUUUURLDULDDLLDDRLLURLUDULURRRUULURDRUDLRLLLRDDLULLDRURDDLLDUDRUDRLRRLULLDRRDULDLRDDRDUURDRRRLRDLDUDDDLLUDURRUUULLDRLUDLDRRRRDDDLLRRDUURURLRURRDUDUURRDRRUDRLURLUDDDLUDUDRDRURRDDDDRDLRUDRDRLLDULRURULULDRLRLRRLDURRRUL"])

(defn keypadSquare [state] (+ (* (state :y) 3) (state :x) 1))
(defn keypadDiamond [state]
  (condp = (state :x)
    0 5
    1 (condp = (state :y)
        1 2
        2 6
        3 "A")
    2 (condp = (state :y)
        0 1
        1 3
        2 7
        3 "B"
        4 "D")
    3 (condp = (state :y)
        1 4
        2 8
        3 "C")
    4 9))

(defn moveSquare [state direction]
  (condp = direction
    \D (if (< (state :y) 2)
         {:x (state :x) :y (+ (state :y) 1)}
         state)
    \L (if (> (state :x) 0)
         {:x (- (state :x) 1) :y (state :y)}
         state)
    \R (if (< (state :x) 2)
         {:x (+ (state :x) 1) :y (state :y)}
         state)
    \U (if (> (state :y) 0)
         {:x (state :x) :y (- (state :y) 1)}
         state)))
(defn moveDiamond [state direction]
  (condp = direction
    \D (if (or (and (= (state :x) 0) (= (state :y) 2))
               (and (= (state :x) 1) (= (state :y) 3))
               (and (= (state :x) 2) (= (state :y) 4))
               (and (= (state :x) 3) (= (state :y) 3))
               (and (= (state :x) 4) (= (state :y) 2)))
         state
         {:x (state :x) :y (+ (state :y) 1)})
    \L (if (or (and (= (state :x) 2) (= (state :y) 0))
               (and (= (state :x) 1) (= (state :y) 1))
               (and (= (state :x) 0) (= (state :y) 2))
               (and (= (state :x) 1) (= (state :y) 3))
               (and (= (state :x) 2) (= (state :y) 4)))
         state
         {:x (- (state :x) 1) :y (state :y)})
    \R (if (or (and (= (state :x) 2) (= (state :y) 0))
               (and (= (state :x) 3) (= (state :y) 1))
               (and (= (state :x) 4) (= (state :y) 2))
               (and (= (state :x) 3) (= (state :y) 3))
               (and (= (state :x) 2) (= (state :y) 4)))
         state
         {:x (+ (state :x) 1) :y (state :y)})
    \U (if (or (and (= (state :x) 0) (= (state :y) 2))
               (and (= (state :x) 1) (= (state :y) 1))
               (and (= (state :x) 2) (= (state :y) 0))
               (and (= (state :x) 3) (= (state :y) 1))
               (and (= (state :x) 4) (= (state :y) 2)))
         state
         {:x (state :x) :y (- (state :y) 1)})))

(defn movesSquare [state moveList]
  (let [location (reduce moveSquare state (seq moveList))]
    {:code (conj (get state :code []) (keypadSquare location)) :x (location :x) :y (location :y)}))
(defn movesDiamond [state moveList]
  (let [location (reduce moveDiamond state (seq moveList))]
    {:code (conj (get state :code []) (keypadDiamond location)) :x (location :x) :y (location :y)}))

(defn main []
  (let [guess (reduce movesSquare {:x 1 :y 1} data)
        reality (reduce movesDiamond {:x 0 :y 2} data)]
    (println (str/join (guess :code)))
    (println (str/join (reality :code)))))

(nth (repeatedly main) (- (Integer/parseInt (or (first *command-line-args*) "1")) 1))
