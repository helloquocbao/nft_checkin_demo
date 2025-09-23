module nft_checkin::nft_rarity;

/// Trả về rarity dựa vào seed
public fun get_rarity(seed: u64): u8 {
    let r = seed % 100;
    if (r < 70) {
        0 // Common
    } else if (r < 95) {
        1 // Epic
    } else {
        2 // Legendary
    }
}
