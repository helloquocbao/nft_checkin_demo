module nft_checkin::utils_random;

use std::bcs;
use sui::hash;

/// Random bằng hash(sender + epoch)
public fun rand_u64(ctx: &TxContext): u64 {
    let sender = tx_context::sender(ctx);
    let epoch = tx_context::epoch(ctx);

    // Tạo seed từ sender và epoch
    let mut seed_data = bcs::to_bytes(&sender);
    let epoch_bytes = bcs::to_bytes(&epoch);
    seed_data.append(epoch_bytes);

    let hash_result = hash::blake2b256(&seed_data);

    // Chuyển đổi 8 bytes đầu thành u64
    let mut result: u64 = 0;
    let mut i = 0;
    while (i < 8 && i < hash_result.length()) {
        result = result * 256 + (hash_result[i] as u64);
        i = i + 1;
    };
    result
}
