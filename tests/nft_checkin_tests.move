module nft_checkin::hello_test {
    use std::debug;
    use nft_checkin::hello;

    #[test]
    fun test_say_hello() {
        let msg = hello::say_hello();
        debug::print(&msg);
        // Sau này có thể assert_eq! nếu muốn so sánh giá trị
    }
}
