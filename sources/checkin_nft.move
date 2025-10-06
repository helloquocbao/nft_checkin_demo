module checkin_nft::checkin_nft {
    use std::string;
     use sui::tx_context;
    use sui::tx_context::TxContext;
    use sui::transfer;
    use sui::object;
    use sui::event;
    use sui::random;
    use checkin_nft::rarity_helper;
    use checkin_nft::events;
    use checkin_nft::constants;

    /// NFT có thể nâng cấp (gacha / re-roll)
    public struct CheckinNFT has key, store {
        id: UID,
        name: string::String,
        image_url: string::String,
        rarity: string::String,
        completion: u64,
        owner: address,
    }

    /// Mint NFT mới
  public entry fun mint(
    name: string::String,
    image_url: string::String,
     r: &random::Random,
    ctx: &mut TxContext
) {
    let sender = tx_context::sender(ctx);
    let rarity = rarity_helper::random_rarity(r, ctx);
    let completion = rarity_helper::random_completion(r, ctx);

    let nft = CheckinNFT {
        id: object::new(ctx),
        name,
        image_url,
        rarity,
        completion,
        owner: sender,
    };

  events::emit_mint_event(sender, rarity, completion);
    transfer::transfer(nft, sender);
}

    /// Upgrade chỉ số NFT (chỉ chủ sở hữu mới có quyền)
  public entry fun upgrade(
    nft: &mut CheckinNFT,
      r: &random::Random,
    ctx: &mut TxContext
) {
    let sender = tx_context::sender(ctx);
    assert!(nft.owner == sender, 0);

    let new_completion = rarity_helper::random_completion(r, ctx);
    let new_rarity = rarity_helper::random_rarity(r, ctx);

    nft.completion = new_completion;
    nft.rarity = new_rarity;

  events::emit_upgrade_event(sender, new_rarity, new_completion);
}


public entry fun transfer_nft(
    nft: CheckinNFT,
    recipient: address,
    ctx: &mut TxContext
) {
    let sender = tx_context::sender(ctx);
    assert!(get_owner(&nft) == sender, 0);

    let mut nft_mut = nft;
    nft_mut.owner = recipient;
    transfer::transfer(nft_mut, recipient);
}

    public fun get_owner(nft: &CheckinNFT): address {
    nft.owner
}
}
