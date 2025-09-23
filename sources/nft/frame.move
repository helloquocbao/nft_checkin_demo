module nft_checkin::nft_frame;

use sui::object::{Self, UID};

/// NFT struct khung avatar
public struct AvatarFrame has key, store {
    id: UID,
    owner: address,
    collection_id: u64,
    rarity: u8, // 0=Common,1=Epic,2=Legendary
    perfection_score: u64, // 1–10000 (x100 để có số thập phân)
}
