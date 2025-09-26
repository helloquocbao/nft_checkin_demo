module nft_checkin::collection;

/// Struct bộ sưu tập avatar
public struct AvatarCollection has key, store {
    id: UID, // Đúng chuẩn Sui object
    name: vector<u8>,
    description: vector<u8>,
    base_uri: vector<u8>,
    creator: address,
}

const ADMIN: address = @0xee81e242c734fed6a4a9ae7664b9de91057fe29aadbdb36d1c32f26d902daa64;

public entry fun create_collection(
    name: vector<u8>,
    description: vector<u8>,
    base_uri: vector<u8>,
    ctx: &mut TxContext,
) {
    assert!(tx_context::sender(ctx) == ADMIN, 100);

    let collection = AvatarCollection {
        id: object::new(ctx), // Tạo UID mới tại đây
        name,
        description,
        base_uri,
        creator: tx_context::sender(ctx),
    };
    transfer::transfer(collection, ADMIN);
}
