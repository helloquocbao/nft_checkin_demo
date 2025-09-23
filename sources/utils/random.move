module nft_checkin::utils_random;

use std::vector;
use sui::hash;
use sui::tx_context::TxContext;

/// Random bằng hash(tx_digest)
public fun rand_u64(ctx: &TxContext): u64 {
    let digest = tx_context::digest(ctx);
    let h = hash::sha3_256(digest);
    // lấy 8 byte cuối làm u64
    u64::from_le_bytes(vector::sub(h, 24, 8))
}
