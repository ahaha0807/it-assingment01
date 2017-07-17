class MoneyChecker 
    @@Possible_money_type = [10, 50, 100, 500, 1000]
    def self.get_possible_money_type
        return @@Possible_money_type
    end

    def self.to_harf_number(input)
        input.tr('０-９', '0-9').to_i
    end

    def self.check_possible_money(input)
        return @@Possible_money_type.any? {|item| item == input}
    end
    
    def self.check(input)
        input = to_harf_number(input)
        isPossibleAccept = check_possible_money(input)

        until isPossibleAccept do
            puts "受け付けることが出来ないお金が投入されました。"
            puts "釣り銭として排出します。"

            puts input

            puts '以下の' + @@Possible_money_type.size.to_s + '種類の中から選択してください'
            @@Possible_money_type.each {|item| puts "- " + item.to_s + "円\n"}
           
            input = gets.chomp!

            if input == "管理者" || input == "admin"
                Stocker.display_lanes()
                input = 0
            else
                input =MoneyChecker.check(input)
                isPossibleAccept = check_possible_money(input)
            end
        end
        return input
    end
end