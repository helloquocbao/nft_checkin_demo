module nft_checkin::nft_perfection;

/// Sinh độ hoàn hảo lệch (scale 1–10000 → 1.00–100.00)
public fun get_perfection(seed: u64): u64 {
    let r = seed % 10000; // 0..9999
    if (r < 7000) {
        100 + (r % 7000) // 1.00 – 70.00
    } else if (r < 9500) {
        7001 + (r % 2500) // 70.01 – 90.00
    } else if (r < 9900) {
        9001 + (r % 400) // 90.01 – 98.99
    } else {
        9900 + (r % 100) // 99.00 – 100.00
    }
}
