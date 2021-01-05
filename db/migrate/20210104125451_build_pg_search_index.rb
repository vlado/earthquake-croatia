class BuildPgSearchIndex < ActiveRecord::Migration[6.1]
  def change
    # also available as rake task:
    # rails "pg_search:multisearch:rebuild[Ad]"
    PgSearch::Multisearch.rebuild(Ad)
  end
end
