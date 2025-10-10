module checkin_nft::checkin_nft {
    use std::hash;
    use std::string;
    use std::bcs;
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::object;
    use sui::event;
    use checkin_nft::events;

    public struct CheckinNFT has key, store {
        id: UID,
        name: string::String,
        image_url: string::String,
        rarity: string::String,
        completion: u64,
        owner: address,
        latitude: string::String,   // 🧭 Vĩ độ
        longitude: string::String,  // 🧭 Kinh độ
    }

    /// 🎲 Sinh số "ngẫu nhiên" 1–100 dựa trên digest hash
    fun random_number(ctx: &TxContext): u64 {
        // ✅ digest có kiểu `object::ID`, encode ra bytes bằng BCS
        let digest = tx_context::digest(ctx);
        let seed = bcs::to_bytes(digest); // 👈 bỏ dấu & để truyền by-value

        // ✅ Hash bằng SHA3-256
        let hash_bytes = hash::sha3_256(seed);

        // ✅ Lấy 8 byte đầu tiên để tạo u64
        let mut val: u64 = 0;
        let mut i = 0;
        while (i < 8) {
           val = (val << 8) | ((*vector::borrow(&hash_bytes, i)) as u64);

            i = i + 1;
        };

        // ✅ Random trong khoảng 1–100
        (val % 100) + 1
    }

    /// 📊 Xác định độ hiếm (rarity)
    public fun rarity_from_number(num: u64): string::String {
        if (num <= 80) {
            string::utf8(b"Common")
        } else if (num <= 95) {
            string::utf8(b"Epic")
        } else {
            string::utf8(b"Legendary")
        }
    }

    /// 🪄 Mint NFT mới (không cần Random object)
    public entry fun mint(
        name: string::String,
        image_url: string::String,
         latitude: string::String,
        longitude: string::String,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);

        let num = random_number(ctx);
        let rarity = rarity_from_number(num);
        let completion = num;

        let nft = CheckinNFT {
            id: object::new(ctx),
            name,
            image_url,
            rarity,
            completion,
            owner: sender,
            latitude,
            longitude,
        };

        events::emit_mint_event(sender, rarity, completion);
        transfer::transfer(nft, sender);
    }

    /// 🔄 Transfer NFT
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

    /// 📍 Lấy chủ sở hữu NFT
    public fun get_owner(nft: &CheckinNFT): address {
        nft.owner
    }


  


}
