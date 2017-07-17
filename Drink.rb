class Drink
    def initialize(name, price, initial_stock)
        @name = name
        @price = price
        @stock = initial_stock
    end

    def get_data
        puts @name
        puts @price
        puts @stock
    end
end