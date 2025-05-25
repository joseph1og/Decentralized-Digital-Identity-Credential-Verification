;; Credential Schema Contract
;; Standardizes identity claim formats and manages schema definitions

(define-constant ERR-NOT-AUTHORIZED (err u200))
(define-constant ERR-SCHEMA-EXISTS (err u201))
(define-constant ERR-SCHEMA-NOT-FOUND (err u202))
(define-constant ERR-INVALID-VERSION (err u203))

;; Contract owner
(define-data-var contract-owner principal tx-sender)

;; Schema definitions
(define-map credential-schemas
  { schema-id: (string-ascii 64), version: uint }
  {
    name: (string-ascii 128),
    description: (string-ascii 256),
    fields: (list 20 (string-ascii 64)),
    required-fields: (list 20 (string-ascii 64)),
    created-by: principal,
    created-at: uint,
    status: (string-ascii 16)
  }
)

;; Schema usage tracking
(define-map schema-usage
  { schema-id: (string-ascii 64) }
  { usage-count: uint, last-used: uint }
)

;; Create a new credential schema
(define-public (create-schema (schema-id (string-ascii 64))
                             (name (string-ascii 128))
                             (description (string-ascii 256))
                             (fields (list 20 (string-ascii 64)))
                             (required-fields (list 20 (string-ascii 64))))
  (let ((existing-schema (map-get? credential-schemas { schema-id: schema-id, version: u1 })))
    (if (is-some existing-schema)
      ERR-SCHEMA-EXISTS
      (begin
        (map-set credential-schemas
          { schema-id: schema-id, version: u1 }
          {
            name: name,
            description: description,
            fields: fields,
            required-fields: required-fields,
            created-by: tx-sender,
            created-at: block-height,
            status: "active"
          }
        )
        (map-set schema-usage
          { schema-id: schema-id }
          { usage-count: u0, last-used: u0 }
        )
        (ok schema-id)
      )
    )
  )
)

;; Update schema usage
(define-public (increment-schema-usage (schema-id (string-ascii 64)))
  (let ((current-usage (default-to { usage-count: u0, last-used: u0 }
                                  (map-get? schema-usage { schema-id: schema-id }))))
    (map-set schema-usage
      { schema-id: schema-id }
      {
        usage-count: (+ (get usage-count current-usage) u1),
        last-used: block-height
      }
    )
    (ok true)
  )
)

;; Get schema definition
(define-read-only (get-schema (schema-id (string-ascii 64)) (version uint))
  (map-get? credential-schemas { schema-id: schema-id, version: version })
)

;; Get schema usage statistics
(define-read-only (get-schema-usage (schema-id (string-ascii 64)))
  (map-get? schema-usage { schema-id: schema-id })
)

;; Validate if schema exists and is active
(define-read-only (is-schema-valid (schema-id (string-ascii 64)) (version uint))
  (match (map-get? credential-schemas { schema-id: schema-id, version: version })
    schema (is-eq (get status schema) "active")
    false
  )
)
