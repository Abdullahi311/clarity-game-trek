;; Battle system
(define-map monsters 
  uint
  {
    name: (string-ascii 32),
    health: uint,
    strength: uint,
    experience-reward: uint,
    min-level: uint
  }
)

;; Initialize some monsters
(map-set monsters u1 {
  name: "Goblin",
  health: u50,
  strength: u5,
  experience-reward: u10,
  min-level: u1
})

;; Battle monster
(define-public (battle-monster (monster-id uint))
  (let
    (
      (player (unwrap! (map-get? characters tx-sender) (err u404)))
      (monster (unwrap! (map-get? monsters monster-id) (err u404)))
    )
    (asserts! (>= (get level player) (get min-level monster)) (err u403))
    (if (> (get strength player) (get strength monster))
      (ok (map-set characters tx-sender 
        (merge player {
          experience: (+ (get experience player) (get experience-reward monster))
        })))
      (err u500) ;; Player lost
    )
  )
)

;; Get monster details
(define-read-only (get-monster (monster-id uint))
  (ok (map-get? monsters monster-id))
)
