class DeleteSubFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_reference :posts, :sub
  end
end
