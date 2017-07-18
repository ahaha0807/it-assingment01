class Deposit
    def initialize
        @last_inputted_money = 0
        @total = 0
    end

    def get_last_inputted_money
        @last_inputted_money
    end

    def get_total
        @total
    end

    def set_last_inputted_money(_last_inputted_money)
        @last_inputted_money = _last_inputted_money
    end

    def set_total(_total)
        @total = _total
    end

    def calclate_charge(unit_price)
        self.set_total(self.get_total - unit_price)
    end

    def return_charge(charge)
        puts 'お釣りは、' + charge.to_s + '円です。'
        self.set_total(0)
        self.set_last_inputted_money(0)
    end

    def accept_money(_contents = 0)
        possible_money_type = MoneyChecker.get_possible_money_type()

        output_guide = "【お金を投入してください。】\n"
        output_guide <<  "投入できる種類は以下の" + possible_money_type.size.to_s + "種類のみです\n"
        possible_money_type.each {|item| output_guide += "- " + item.to_s + "円\n"}
        puts output_guide

        if _contents == 0
            contents = gets.chomp!
        else
            contents = _contents
        end

        if contents == "管理者" || contents == "admin"
            @last_inputted_money = 0
            return true
        else
            @last_inputted_money = MoneyChecker.check(contents)
            @total += @last_inputted_money
            puts @last_inputted_money.to_s + '円投入されました'
            return false
        end
    end
end