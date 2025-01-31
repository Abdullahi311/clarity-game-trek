;; Character traits
(define-trait character-trait
  (
    (get-name () (response (string-ascii 32) uint))
    (get-level () (response uint uint))
    (get-experience () (response uint uint))
    (get-health () (response uint uint))
    (get-strength () (response uint uint))
  )
)

;; Data structures
(define-map characters
  principal
  {
    name: (string-ascii 32),
    level: uint,
    experience: uint,
    health: uint,
    strength: uint
  }
)

;; Create character
(define-public (create-character (name (string-ascii 32)))
  (let
    (
      (character {
        name: name,
        level: u1,
        experience: u0,
        health: u100,
        strength: u10
      })
    )
    (ok (map-set characters tx-sender character))
  )
)

;; Get character stats
(define-read-only (get-character (player principal))
  (ok (map-get? characters player))
)

;; Level up character
(define-public (level-up)
  (let
    ((current-char (unwrap! (map-get? characters tx-sender) (err u404))))
    (ok (map-set characters tx-sender
      (merge current-char {
        level: (+ (get level current-char) u1),
        health: (+ (get health current-char) u10),
        strength: (+ (get strength current-char) u2)
      })
    ))
  )
)
