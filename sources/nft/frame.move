module nft_checkin::nft_frame;

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

/// Getter functions
public fun owner(frame: &AvatarFrame): address {
    frame.owner
}

public fun collection_id(frame: &AvatarFrame): u64 {
    frame.collection_id
}

public fun rarity(frame: &AvatarFrame): u8 {
    frame.rarity
}

public fun perfection_score(frame: &AvatarFrame): u64 {
    frame.perfection_score
}
