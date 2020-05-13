class CreateJoinTableBlogsTopics < ActiveRecord::Migration[5.2]
  def change
    create_join_table :blogs, :topics do |t|
      t.index [:blog_id, :topic_id]
      t.index [:topic_id, :blog_id]
    end
  end
end
