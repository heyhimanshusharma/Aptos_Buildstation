module MyModule::PeerReviewRegistry {
    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a reviewer's reputation profile
    struct ReviewerProfile has store, key {
        total_reviews: u64,     // Total number of reviews submitted
        reputation_score: u64,  // Reputation score based on review quality
    }

    /// Struct representing an anonymous peer review attestation
    struct ReviewAttestation has store {
        paper_id: u64,          // ID of the paper being reviewed
        reviewer_address: address, // Address of the reviewer (for reputation tracking)
        score: u8,              // Review score (1-10)
        is_anonymous: bool,     // Whether the review is anonymous
    }

    /// Struct to store all review attestations
    struct ReviewRegistry has store, key {
        attestations: vector<ReviewAttestation>,
        next_paper_id: u64,
    }

    /// Function to initialize a reviewer profile
    public fun create_reviewer_profile(reviewer: &signer) {
        let profile = ReviewerProfile {
            total_reviews: 0,
            reputation_score: 100, // Starting reputation score
        };
        move_to(reviewer, profile);
    }

    /// Function to submit an anonymous peer review attestation
    public fun submit_review(
        reviewer: &signer, 
        registry_owner: address, 
        paper_id: u64, 
        score: u8
    ) acquires ReviewerProfile, ReviewRegistry {
        let reviewer_addr = signer::address_of(reviewer);
        
        // Update reviewer's profile
        let profile = borrow_global_mut<ReviewerProfile>(reviewer_addr);
        profile.total_reviews = profile.total_reviews + 1;
        profile.reputation_score = profile.reputation_score + (score as u64);

        // Create review attestation
        let attestation = ReviewAttestation {
            paper_id,
            reviewer_address: reviewer_addr,
            score,
            is_anonymous: true,
        };

        // Add to registry
        let registry = borrow_global_mut<ReviewRegistry>(registry_owner);
        vector::push_back(&mut registry.attestations, attestation);
    }

    /// Function to initialize the review registry (called by registry owner)
    public fun initialize_registry(owner: &signer) {
        let registry = ReviewRegistry {
            attestations: vector::empty<ReviewAttestation>(),
            next_paper_id: 1,
        };
        move_to(owner, registry);
    }
}