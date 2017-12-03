(ns spiral.core-spec
  (:require [speclj.core :refer :all]
            [spiral.core :refer :all]))

(describe "spiral memory"
          (it "Counts the number of steps from 1"
              (should= 0
                       (get-distance 1)))


          )

(describe "works for 1"
          (it "assigns [0 0] to 1"
              (should= [0 0]
                       (get-coordinates 1)))

          )

(describe "next move and directions"
          (it "right"
              (should= [ "UP" [1 0]]
                       (right [0 0])))

          (it "up"
              (should= [ "LEFT" [0 1]]
                       (up [0 0])))

          (it "left"
              (should= [ "DOWN" [-1 0]]
                       (left [0 0])))

          (it "down"
              (should= ["RIGHT" [0 -1]]
                       (down [0 0]))))

(describe "finds next coordinates"
          (it "finds the next move"
              (should= ["UP" [1 0]]
                       (get-next-coordinate ["RIGHT" [0 0]])))

          (it "finds the next move - up"
              (should= ["LEFT" [1 1]]
                       (get-next-coordinate ["UP" [1 0]])))

          (it "finds the next move - left"
              (should= ["DOWN" [0 1]]
                       (get-next-coordinate ["LEFT" [1 1]])))

          (it "finds the next move - down"
              (should= ["RIGHT" [0 0]]
                       (get-next-coordinate ["DOWN" [0 1]])))

          )
