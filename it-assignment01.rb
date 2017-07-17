require './Money_checker.rb'
require './Stocker.rb'
require './Drink.rb'
require './Deposit.rb'

def ask_what_to_buy
    selected = '払い戻し'
    puts selected.to_s + 'と入力しました'    
    return false
end

def admin_mode
    Stocker.display_lanes()
end

total = 0
isRepeat = true
isAdmin = false

# 自販機の初期化
stocker = Stocker.new
stocker.set_drink_lane("コーラ", 120, 5)

# お金の投入処理
deposit = Deposit.new()
while isRepeat do
    isAdmin = deposit.accept_money()
    
    if isAdmin
        admin_mode() 
        break
    end

    puts '合計' + deposit.get_total.to_s + '円投入されています。'
    isRepeat = Deposit.ask_finish()
end

# 購入処理
item = ask_what_to_buy()
unless item
    puts '払い戻し操作が実行されました。'
    puts 'お釣りは、' + deposit.get_total.to_s + '円です。' 
    total -= total
end