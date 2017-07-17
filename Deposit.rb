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

    def self.ask_finish(answer = '')
        puts 'お金をまだ入れますか？ (はい/いいえ)'
        if answer == ''
            answer = gets.chomp!.to_s 
        end

        if answer == 'はい' || answer.downcase == 'yes' || answer.downcase == 'y'
            return true
        elsif answer == 'いいえ' || answer.downcase == 'no' || answer.downcase == 'n'
            return false
        else
            ask_finish()
        end
    end
end