(ns spiral.core)

(defn down [coordinates]
  (let [new-y (dec ( get coordinates 1))]
    (vector "RIGHT" (vector (get coordinates 0) new-y)) )
  )

(defn left [coordinates]
  (let [new-x (dec ( get coordinates 0))]
    (vector "DOWN" (vector new-x (get coordinates 1))))
  )

(defn up [coordinates]
  (let [new-y (inc ( get coordinates 1))]
    (vector "LEFT" (vector (get coordinates 0) new-y)) )
  )

(defn right [coordinates]
  (let [new-x (inc (get coordinates 0))]
    (vector "UP" (vector new-x (get coordinates 0))) ))

(defn get-next-coordinate [current-coordinates]
  (let [next-move (get current-coordinates 0)
        coordinates (get current-coordinates 1)]
    (cond
      (= next-move "RIGHT") (right coordinates)
      (= next-move "UP") (up coordinates)
      (= next-move "LEFT") (left coordinates)
      (= next-move "DOWN") (down coordinates)
      )
    )
  )

(defn get-coordinates [number]
  (if (= number 1)
    [0 0])
  )

(defn get-distance [number]
  0)

(defn -main [& args]
  (get-distance args))


