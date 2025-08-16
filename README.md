# Peer Review Registry (Aptos Move)

## Description
The Peer Review Registry is a minimal **anonymous peer review system** implemented as a Move smart contract on the Aptos blockchain. It allows reviewers to create a reputation profile, submit anonymous reviews for academic papers, and store all review attestations in a decentralized registry managed by a designated owner.

By combining blockchain immutability with pseudonymity, this module ensures that reviews are tamper-proof, transparent, and resistant to censorship.

## Vision
The long-term vision of the Peer Review Registry is to create a **decentralized, reputation-based peer review ecosystem** for research and academic publishing. Instead of relying on centralized journals or publishers, this system empowers researchers worldwide to submit, evaluate, and validate scholarly work in an open and anonymous manner.

Key guiding principles:
- **Transparency** – All reviews are stored on-chain for verifiable authenticity.
- **Anonymity** – Reviewers remain pseudonymous, protecting against bias and retaliation.
- **Reputation-driven trust** – Reviewers build credibility through consistent, quality contributions.

## Future Scope
The current module provides a minimal foundation. Future improvements can include:
- Paper submission functionality (with metadata storage on-chain or via IPFS/Arweave)
- Weighted reputation scoring, factoring in peer endorsements
- Incentive mechanisms (token rewards, staking, or penalties for bad actors)
- Advanced privacy features (zero-knowledge proofs to enhance anonymity)
- Integration with decentralized identity (DID) standards
- DAO-based governance for community-driven moderation

## Usage

### 1. Initialize Registry (by registry owner)
```bash
aptos move run \
  --function-id <ADDR>::PeerReviewRegistry::initialize_registry \
  --args signer
```

### 2. Create Reviewer Profile (by each reviewer)
```bash
aptos move run \
  --function-id <ADDR>::PeerReviewRegistry::create_reviewer_profile \
  --args signer
```

### 3. Submit a Review
```bash
aptos move run \
  --function-id <ADDR>::PeerReviewRegistry::submit_review \
  --args signer <registry_owner_addr> <paper_id:u64> <score:u8>
```

### Contract Address

<img width="1885" height="873" alt="image" src="https://github.com/user-attachments/assets/6c91091d-6498-433d-996d-43f355099ad7" />

