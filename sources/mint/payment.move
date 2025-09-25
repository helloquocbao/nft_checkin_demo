module nft_checkin::mint_payment;

use sui::coin::Coin;
use sui::sui::SUI;

/// Yêu cầu thêm phí 1 SUI khi mint (ngoài gas)
/// TODO: chuyển coin này về ví chủ dự án
public fun pay_extra(coin: Coin<SUI>): Coin<SUI> {
    coin
}
