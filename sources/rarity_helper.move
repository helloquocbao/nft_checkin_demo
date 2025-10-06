module checkin_nft::rarity_helper {
    use std::string;
    use sui::random::{Self, Random};
    use sui::tx_context::TxContext;
    use checkin_nft::constants;

    /// Random rarity dựa theo tỷ lệ trong constants
    public fun random_rarity(r: &Random, ctx: &mut TxContext): string::String {
        // ✅ new_generator cần r + ctx
        let mut gen = random::new_generator(r, ctx);

        let seed = random::generate_u64_in_range(&mut gen, 0, 100);

        if (seed < constants::common_rate()) {
            string::utf8(b"Common")
        } else if (seed < constants::common_rate() + constants::epic_rate()) {
            string::utf8(b"Epic")
        } else {
            string::utf8(b"Legendary")
        }
    }

    /// Random completion trong khoảng 0–MAX_COMPLETION
    public fun random_completion(r: &Random, ctx: &mut TxContext): u64 {
        let mut gen = random::new_generator(r, ctx);
        random::generate_u64_in_range(&mut gen, 0, constants::max_completion() + 1)
    }
}
