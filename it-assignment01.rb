require './Money_checker.rb'
require './Stocker.rb'
require './Drink.rb'
require './Deposit.rb'

def ask_what_to_buy(depositted_price, selected = '')
    if selected == ''
        puts '何を購入しますか？'
        puts '預り金 : ' + depositted_price.to_s + '円'
        Stocker.display_commodities()

        selected = gets.chomp!
    end

    if selected == '払い戻し' || selected == '払い出し' || selected == 'return' || selected == '取り消し'
        return 'return'
    else
        return selected
    end
end

def ask_finish(answer = '')
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

def check_selected_item(item, deposit)
    # ガード節
    if deposit.get_total == 0 || deposit.nil?
        return false
    end
    if item.nil?
        return false
    end
    if item.get_stock <= 0
        return false
    end

    # 本体
    if deposit.get_total >= item.get_price
        return true
    end
end

def admin_mode
    Stocker.display_lanes()
end

isEnd = false

# 自販機の初期化
stocker = Stocker.new
stocker.set_drink_lane("コーラ", 120, 5)
stocker.set_drink_lane("レッドブル", 200, 5)
stocker.set_drink_lane("水", 100, 5)

until isEnd
    isAdmin = false
    isRepeat = true
    # お金の投入処理
    deposit = Deposit.new()
    while isRepeat do
        isAdmin = deposit.accept_money()
        
        if isAdmin
            admin_mode() 
            break
        end

        puts '合計' + deposit.get_total.to_s + '円投入されています。'
        puts 'お金をまだ入れますか？ (はい/いいえ)'
        isRepeat = ask_finish()
    end

    # 購入処理
    item = ask_what_to_buy(deposit.get_total)
    item = stocker.find(item)

    if item == 'return'
        puts '払い戻し操作が実行されました。'
        
        charge = deposit.calclate_charge(0)
        deposit.return_charge(charge)
    elsif check_selected_item(item, deposit)
        stocker.buy_selected_item(item)
        charge = deposit.calclate_charge(item.get_price)
        puts 'お釣りは、' + charge.to_s + '円です。'
        
        deposit.set_total(0)
        deposit.set_last_inputted_money(0)
    else
        # TODO: 何もしないようにしないと。一番最初に戻るから、金額がリセットされてまう
        puts "選択した飲み物は購入できません。\n払い戻しします。"

        charge = deposit.calclate_charge(0)
        deposit.return_charge(charge)
    end

    puts '終了しますか？'
    isEnd = ask_finish()
end