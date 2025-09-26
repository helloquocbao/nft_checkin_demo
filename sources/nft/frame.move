module nft_checkin::nft_frame;

use nft_checkin::nft_perfection;
use nft_checkin::nft_rarity;
use nft_checkin::utils_random;

/// NFT struct khung avatar
public struct AvatarFrame has key, store {
    id: UID,
    owner: address,
    collection_id: u64,
    rarity: u8, // 0=Common,1=Epic,2=Legendary
    perfection_score: u64, // 1–10000 (x100 để có số thập phân)
}

/// Constructor function để tạo AvatarFrame
public fun new(
    owner: address,
    collection_id: u64,
    rarity: u8,
    perfection_score: u64,
    ctx: &mut TxContext,
): AvatarFrame {
    AvatarFrame {
        id: object::new(ctx),
        owner,
        collection_id,
        rarity,
        perfection_score,
    }
}

/// Mint NFT AvatarFrame, trả về cho client
public entry fun mint_and_transfer(position: u64, ctx: &mut TxContext) {
    let seed = utils_random::rand_u64(ctx);
    let rarity = nft_rarity::get_rarity(seed);
    let perfection_score = nft_perfection::get_perfection(seed);

    let frame = new(
        tx_context::sender(ctx),
        position,
        rarity,
        perfection_score,
        ctx,
    );
    transfer::transfer(frame, tx_context::sender(ctx));
}
