class AddCallLinkToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :room, :string
  end
end
