# Peer Review Registry (Aptos Move)

This Move module implements a minimal **anonymous peer review system** on the Aptos blockchain.  
It allows:
- Reviewers to create a reputation profile.
- Reviewers to submit anonymous review attestations for papers.
- A registry owner to manage the collection of all reviews.

---

## Module Overview

### Structs

- **`ReviewerProfile`**
  - Tracks a reviewer's activity and reputation.
  - Fields:
    - `total_reviews: u64` – Number of reviews submitted.
    - `reputation_score: u64` – Reputation score (starts at 100).

- **`ReviewAttestation`**
  - Represents a single review entry.
  - Fields:
    - `paper_id: u64` – Identifier of the paper being reviewed.
    - `reviewer_address: address` – Pseudonymous reviewer account.
    - `score: u8` – Numeric score (1–10).
    - `is_anonymous: bool` – Always set to `true` in this example.

- **`ReviewRegistry`**
  - A global container of all submitted reviews.
  - Fields:
    - `attestations: vector<ReviewAttestation>` – All stored reviews.
    - `next_paper_id: u64` – Placeholder for future paper submissions.

---

## Functions

- **`create_reviewer_profile(reviewer: &signer)`**
  - Initializes a profile for a reviewer.
  - Must be called once before submitting reviews.
  - Sets `total_reviews = 0` and `reputation_score = 100`.

- **`submit_review(reviewer: &signer, registry_owner: address, paper_id: u64, score: u8)`**
  - Allows a reviewer to submit a review for a given paper.
  - Updates reviewer’s profile (`total_reviews` and `reputation_score`).
  - Creates a `ReviewAttestation` and stores it in the global `ReviewRegistry`.

- **`initialize_registry(owner: &signer)`**
  - Must be called by the registry owner to create the `ReviewRegistry`.
  - Prepares an empty vector for storing attestations.

---

## Usage

### 1. Initialize Registry (by registry owner)
```bash
aptos move run \
  --function-id <ADDR>::PeerReviewRegistry::initialize_registry \
  --args signer
