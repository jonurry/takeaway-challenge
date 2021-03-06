require_relative 'menu'
require_relative 'order'
require_relative 'sms'

class Takeaway
  def initialize(config)
    @menu = config.fetch(:menu, Menu.new)
    @sms = config.fetch(:sms, SMS.new)
    @order = config.fetch(:order, Order.new(sms))
  end

  def dishes
    menu.dishes
  end

  def place_order
    order.place_order
  end

  def add_to_basket(dish, quantity)
    format_dish(order.add_dish(dish, quantity))
  end

  def total_price
    order.total
  end

  private

  attr_reader :menu, :order, :sms

  def format_dish(item)
    quantity = item[:quantity]
    dish = item[:dish]
    "#{quantity} * #{dish.name} = £#{dish.price}"
  end
end
