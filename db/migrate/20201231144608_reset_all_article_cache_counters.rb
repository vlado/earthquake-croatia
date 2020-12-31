class ResetAllArticleCacheCounters < ActiveRecord::Migration[6.1]
  def up
    Ad.all.each do |ad|
      Ad.reset_counters(ad.id, :comments)
    end
  end
  def down
  end
end
