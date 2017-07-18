class Drink
    def initialize(_name, _price, initial_stock)
        @name = _name
        @price = _price
        @stock = initial_stock
    end

    def print_data
        puts @name
        puts @price
        puts @stock
    end

    def get_name
        @name
    end

    def get_price
        @price
    end
    
    def get_stock
        @stock
    end

    def set_stock(_stock)
        @stock = _stock
    end
end