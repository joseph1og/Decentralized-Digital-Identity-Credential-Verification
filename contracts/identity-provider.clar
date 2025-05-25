;; Identity Provider Verification Contract
;; Manages trusted identity providers and their verification status

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-PROVIDER-EXISTS (err u101))
(define-constant ERR-PROVIDER-NOT-FOUND (err u102))
(define-constant ERR-INVALID-STATUS (err u103))

;; Contract owner
(define-data-var contract-owner principal tx-sender)

;; Identity provider data structure
(define-map identity-providers
  { provider-id: (string-ascii 64) }
  {
    name: (string-ascii 128),
    public-key: (buff 33),
    status: (string-ascii 16),
    registered-at: uint,
    verified-at: (optional uint)
  }
)

;; Provider verification status tracking
(define-map provider-verifications
  { provider-id: (string-ascii 64), verifier: principal }
  { verified-at: uint, trust-level: uint }
)

;; Register a new identity provider
(define-public (register-provider (provider-id (string-ascii 64))
                                 (name (string-ascii 128))
                                 (public-key (buff 33)))
  (let ((existing-provider (map-get? identity-providers { provider-id: provider-id })))
    (if (is-some existing-provider)
      ERR-PROVIDER-EXISTS
      (begin
        (map-set identity-providers
          { provider-id: provider-id }
          {
            name: name,
            public-key: public-key,
            status: "pending",
            registered-at: block-height,
            verified-at: none
          }
        )
        (ok provider-id)
      )
    )
  )
)

;; Verify an identity provider (only contract owner)
(define-public (verify-provider (provider-id (string-ascii 64)))
  (let ((provider (unwrap! (map-get? identity-providers { provider-id: provider-id }) ERR-PROVIDER-NOT-FOUND)))
    (if (is-eq tx-sender (var-get contract-owner))
      (begin
        (map-set identity-providers
          { provider-id: provider-id }
          (merge provider {
            status: "verified",
            verified-at: (some block-height)
          })
        )
        (ok true)
      )
      ERR-NOT-AUTHORIZED
    )
  )
)

;; Get provider information
(define-read-only (get-provider (provider-id (string-ascii 64)))
  (map-get? identity-providers { provider-id: provider-id })
)

;; Check if provider is verified
(define-read-only (is-provider-verified (provider-id (string-ascii 64)))
  (match (map-get? identity-providers { provider-id: provider-id })
    provider (is-eq (get status provider) "verified")
    false
  )
)
