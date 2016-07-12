class AddReceiverIdAndSenderIdToChat < ActiveRecord::Migration
  def change
    add_column :messages, :sender_id, :integer
    add_column :messages, :receiver_id, :integer
    add_column :messages, :user_message, :string
    add_column :messages, :channel, :string
  end
end
