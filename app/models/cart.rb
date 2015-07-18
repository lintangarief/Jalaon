class Cart < ActiveRecord::Base
  acts_as_shopping_cart_using :cart_item
  belongs_to :user
  belongs_to :cart
  belongs_to :service
  def taxes
    0
  end

  def tax_pct
    0
  end
end
