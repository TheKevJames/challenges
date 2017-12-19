(require '[clojure.string :as str])
(require '[clojure.set :as set])

; http://adventofcode.com/2016/day/1
(def data "R3, R1, R4, L4, R3, R1, R1, L3, L5, L5, L3, R1, R4, L2, L1, R3, L3, R2, R1, R1, L5, L2, L1, R2, L4, R1, L2, L4, R2, R2, L2, L4, L3, R1, R4, R3, L1, R1, L5, R4, L2, R185, L2, R4, R49, L3, L4, R5, R1, R1, L1, L1, R2, L1, L4, R4, R5, R4, L3, L5, R1, R71, L1, R1, R186, L5, L2, R5, R4, R1, L5, L2, R3, R2, R5, R5, R4, R1, R4, R2, L1, R4, L1, L4, L5, L4, R4, R5, R1, L2, L4, L1, L5, L3, L5, R2, L5, R4, L4, R3, R3, R1, R4, L1, L2, R2, L1, R4, R2, R2, R5, R2, R5, L1, R1, L4, R5, R4, R2, R4, L5, R3, R2, R5, R3, L3, L5, L4, L3, L2, L2, R3, R2, L1, L1, L5, R1, L3, R3, R4, R5, L3, L5, R1, L3, L5, L5, L2, R1, L3, L1, L3, R4, L1, R3, L2, L2, R3, R3, R4, R4, R1, L4, R1, L5")

(defn turn [compass dir] (mod (+ compass (if (= dir "R") 1 -1)) 4))
(defn taxicabDistance [from to] (+ (Math/abs (- (from :x) (to :x))) (Math/abs (- (from :y) (to :y)))))

(defn move [state instr]
  (let [amount (Integer/parseInt (subs instr 1))
        direction (turn (state :face) (subs instr 0 1))
        location (condp = direction
                   0 {:x (+ (state :x) amount) :y (state :y)}
                   1 {:x (state :x)            :y (+ (state :y) amount)}
                   2 {:x (- (state :x) amount) :y (state :y)}
                   3 {:x (state :x)            :y (- (state :y) amount)})]
    (assoc state :face direction :x (location :x) :y (location :y))))

(defn moveUntil [state instr]
  (let [amount (Integer/parseInt (subs instr 1))
        direction (turn (state :face) (subs instr 0 1))
        location (condp = direction
                   0 {:x (+ (state :x) amount) :y (state :y)}
                   1 {:x (state :x)            :y (+ (state :y) amount)}
                   2 {:x (- (state :x) amount) :y (state :y)}
                   3 {:x (state :x)            :y (- (state :y) amount)})
        through (condp = direction
               0 (map #(hash-map :x % :y (state :y)) (range (location :x) (state :x) -1))
               1 (map #(hash-map :x (state :x) :y %) (range (location :y) (state :y) -1))
               2 (map #(hash-map :x % :y (state :y)) (range (location :x) (state :x)))
               3 (map #(hash-map :x (state :x) :y %) (range (location :y) (state :y))))]
    (if (empty? (set/intersection (set through) (set (state :already))))
      (assoc state :already (into (state :already) through) :face direction :x (location :x) :y (location :y))
      (reduced (first (set/intersection (set through) (set (state :already))))))))

(defn main []
  (let [finalLocation (reduce move {:already [{:x 0 :y 0}] :face 0 :x 0 :y 0} (str/split data #", "))
        firstIntersection (reduce moveUntil {:already [{:x 0 :y 0}] :face 0 :x 0 :y 0} (str/split data #", "))]
    (println (taxicabDistance {:x 0 :y 0} finalLocation))
    (println (taxicabDistance {:x 0 :y 0} firstIntersection))))

(nth (repeatedly main) (- (Integer/parseInt (or (first *command-line-args*) "1")) 1))
