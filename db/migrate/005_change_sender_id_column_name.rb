class ChangeSenderIdColumnName < ActiveRecord::Migration
  def change
    rename_column :receive_emails, :sender_id, :player_id
  end
end
