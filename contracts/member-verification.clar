;; Member Verification Contract
;; Validates eligibility of property owners

(define-data-var admin principal tx-sender)

;; Map to store verified members
(define-map members principal bool)

;; Function to add a member (only admin can call)
(define-public (add-member (member-address principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1))
    (ok (map-set members member-address true))
  )
)

;; Function to remove a member (only admin can call)
(define-public (remove-member (member-address principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1))
    (ok (map-delete members member-address))
  )
)

;; Function to check if an address is a verified member
(define-read-only (is-member (address principal))
  (default-to false (map-get? members address))
)

;; Function to transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1))
    (ok (var-set admin new-admin))
  )
)

