script {
    use DiemFramework::DiemAccount;
    use Std::Signer;
    use Std::Vector;

    fun main<Coin>(account1: signer, 
            account2: signer, 
            amount_xus: u64, 
            amount_xdx: u64 
            ) {

        let metadata = Vector::empty<u8>();
        let metadata_signature = Vector::empty<u8>();
        let metadata2 = Vector::empty<u8>();
        let metadata_signature2 = Vector::empty<u8>();
        //First account1 pays account2 in currency XUS
        let account1_withdrawal_cap = DiemAccount::extract_withdraw_capability(&account1);
        let account2_addr = Signer::address_of(&account2);
        DiemAccount::pay_from<Coin>(
                &account1_withdrawal_cap, account2_addr, amount_xus, metadata, metadata_signature
                );
        DiemAccount::restore_withdraw_capability(account1_withdrawal_cap);


        //Then account2 pays account1 in currency XDX
        let account2_withdrawal_cap = DiemAccount::extract_withdraw_capability(&account2);
        let account1_addr = Signer::address_of(&account1);
        DiemAccount::pay_from<Coin>(
                &account2_withdrawal_cap, account1_addr, amount_xdx, metadata2, metadata_signature2
                );
        DiemAccount::restore_withdraw_capability(account2_withdrawal_cap);


    }
}
