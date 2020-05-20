class AddDepositAmountToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :deposit_amount, :integer
  end
end
