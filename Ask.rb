module Ask
    def accept_money
        possible_money_type = MoneyChecker.get_possible_money_type()

        output_guide = "【お金を投入してください。】\n"
        output_guide <<  "投入できる種類は以下の" + possible_money_type.size.to_s + "種類のみです\n"
        possible_money_type.each {|item| output_guide += "- " + item.to_s + "円\n"}
        puts output_guide
        
        input_money = gets.chomp!

        if input_money == "管理者" || input_money == "admin"
            Stocker.display_lanes()
            input_money = 0
        else
            input_money = MoneyChecker.check(input_money)
        end

        puts input_money.to_s + '円投入されました'
        return input_money
    end

    def ask_finish
        puts 'お金をまだ入れますか？ (はい/いいえ)'
        answer = gets.chomp!.to_s
        if answer == 'はい' || answer.downcase == 'yes' || answer.downcase == 'y'
            return true
        elsif answer == 'いいえ' || answer.downcase == 'no' || answer.downcase == 'n'
            return false
        else
            ask_finish()
        end
    end

    def ask_what_to_buy
        selected = '払い戻し'
        puts selected.to_s + 'と入力しました'
        return false
    end

    module_function :accept_money, :ask_finish, :ask_what_to_buy
end