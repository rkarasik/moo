class CreatePostsTable < ActiveRecord::Migration
 def change
  	create_table :posts do |t|
  		t.integer :user_id
  		t.string :email
  		t.string :text
  		t.timestamps
  	end
  end 
end
