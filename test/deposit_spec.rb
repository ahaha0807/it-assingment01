require 'test/unit'
require './Deposit.rb'
require './Money_checker.rb'
require './Stocker.rb'

class DepositTest < Test::Unit::TestCase
    def setup
        @@deposit = Deposit.new
    end
    
    # 受け取り不可能なお金を入れると再起呼び出しされるので無し。
    # TODO: いずれこれをテストできるように本番コードを修正する
    def test_受け取り可能なお金を受け取って追加できるか
        assert_equal(@@deposit.get_last_inputted_money, 0)
        assert_equal(@@deposit.get_total, 0)

        @@deposit.accept_money(10)
        assert_equal(@@deposit.get_last_inputted_money, 10)
        @@deposit.accept_money(50)
        assert_equal(@@deposit.get_last_inputted_money, 50)
        @@deposit.accept_money(100)
        assert_equal(@@deposit.get_last_inputted_money, 100)
        @@deposit.accept_money(500)
        assert_equal(@@deposit.get_last_inputted_money, 500)
        @@deposit.accept_money(1000)
        assert_equal(@@deposit.get_last_inputted_money, 1000)

        assert_equal(@@deposit.get_total, 1660)
    end

    def test_管理者モードを起動できるか
        assert(@@deposit.accept_money("管理者"))
        assert(@@deposit.accept_money("admin"))
    end

    # その他を呼び出すと再起呼び出しされるので無し。
    # TODO: いずれこれをテストできるように本番コードを修正する
    def test_肯定形で入力した時にtrueが返るか
        assert(Deposit.ask_finish('はい'))
        assert(Deposit.ask_finish('YES'))
        assert(Deposit.ask_finish('yes'))
        assert(Deposit.ask_finish('Y'))
        assert(Deposit.ask_finish('y'))
    end 

    def test_否定形で入力した時にfalseが返るか
        assert_equal(false, Deposit.ask_finish('いいえ'))
        assert_equal(false, Deposit.ask_finish('NO'))
        assert_equal(false, Deposit.ask_finish('no'))
        assert_equal(false, Deposit.ask_finish('N'))
        assert_equal(false, Deposit.ask_finish('n'))
    end
end