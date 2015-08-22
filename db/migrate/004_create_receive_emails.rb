class CreateReceiveEmails < ActiveRecord::Migration
  def change
    create_table :receive_emails do |t|
      t.string :subject
      t.integer :sender_id
    end
  end
end
