require './Money_checker.rb'
require './Stocker.rb'
require './Drink.rb'
require './Deposit.rb'

def ask_what_to_buy(selected = '')
    if selected == ''
        puts '何を購入しますか？'
        Stocker.display_commodities()

        selected = gets.chomp!
    end

    if selected == '払い戻し' || selected == '払い出し' || selected == 'return'
        return 'return'
    end

    return selected
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
        isRepeat = Deposit.ask_finish()
    end

    # 購入処理
    item = ask_what_to_buy()

    if item == 'return'
        puts '払い戻し操作が実行されました。'
        deposit.calclate_charge(0)
        puts 'お釣りは、' + deposit.get_total.to_s + '円です。' 
        deposit.set_total(0)
    end

    item = stocker.find(item)

    if check_selected_item(item, deposit)
        stocker.buy_selected_item(item)
        charge = deposit.calclate_charge(item.get_price)
        puts 'お釣りは、' + charge.to_s + '円です。'
        
        deposit.set_total(0)
        deposit.set_last_inputted_money(0)
        # Stocker.display_lanes()
    else
        # 何もしない
        puts "選択した飲み物は購入できません。\n払い戻しします。"

        charge = deposit.calclate_charge(0)
        puts 'お釣りは、' + charge.to_s + '円です。'
        deposit.set_total(0)
        deposit.set_last_inputted_money(0)
    end

    puts '終了しますか？'
    isEnd = Deposit.ask_finish()
end