module nft_checkin::mint_mint;

use nft_checkin::nft_frame::{Self, AvatarFrame};
use nft_checkin::nft_perfection;
use nft_checkin::nft_rarity;
use nft_checkin::utils_random;

/// Mint NFT AvatarFrame
public fun mint(collection_id: u64, ctx: &mut TxContext): AvatarFrame {
    let seed = utils_random::rand_u64(ctx);
    let rarity_level = nft_rarity::get_rarity(seed);
    let perfect_score = nft_perfection::get_perfection(seed);

    nft_frame::new(
        tx_context::sender(ctx),
        collection_id,
        rarity_level,
        perfect_score,
        ctx,
    )
}
