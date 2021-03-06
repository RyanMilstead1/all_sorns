class AddIndexesToEverything < ActiveRecord::Migration[6.0]
  def up
    execute "create index action_idx on sorns using gist(to_tsvector('english', action));"
    execute "create index summary_idx on sorns using gist(to_tsvector('english', summary));"
    execute "create index dates_idx on sorns using gist(to_tsvector('english', dates));"
    execute "create index addresses_idx on sorns using gist(to_tsvector('english', addresses));"
    execute "create index further_info_idx on sorns using gist(to_tsvector('english', further_info));"
    execute "create index supplementary_info_idx on sorns using gist(to_tsvector('english', supplementary_info));"
    execute "create index system_name_idx on sorns using gist(to_tsvector('english', system_name));"
    execute "create index system_number_idx on sorns using gist(to_tsvector('english', system_number));"
    execute "create index security_idx on sorns using gist(to_tsvector('english', security));"
    execute "create index location_idx on sorns using gist(to_tsvector('english', location));"
    execute "create index manager_idx on sorns using gist(to_tsvector('english', manager));"
    execute "create index authority_idx on sorns using gist(to_tsvector('english', authority));"
    execute "create index purpose_idx on sorns using gist(to_tsvector('english', purpose));"
    execute "create index categories_of_individuals_idx on sorns using gist(to_tsvector('english', categories_of_individuals));"
    execute "create index categories_of_record_idx on sorns using gist(to_tsvector('english', categories_of_record));"
    execute "create index source_idx on sorns using gist(to_tsvector('english', source));"
    execute "create index routine_uses_idx on sorns using gist(to_tsvector('english', routine_uses));"
    execute "create index storage_idx on sorns using gist(to_tsvector('english', storage));"
    execute "create index retrieval_idx on sorns using gist(to_tsvector('english', retrieval));"
    execute "create index retention_idx on sorns using gist(to_tsvector('english', retention));"
    execute "create index safeguards_idx on sorns using gist(to_tsvector('english', safeguards));"
    execute "create index access_idx on sorns using gist(to_tsvector('english', access));"
    execute "create index contesting_idx on sorns using gist(to_tsvector('english', contesting));"
    execute "create index notification_idx on sorns using gist(to_tsvector('english', notification));"
    execute "create index exemptions_idx on sorns using gist(to_tsvector('english', exemptions));"
    execute "create index history_idx on sorns using gist(to_tsvector('english', history));"
  end

  def down
    execute "drop index agency_names_idx;"
    execute "drop index action_idx;"
    execute "drop index summary_idx;"
    execute "drop index dates_idx;"
    execute "drop index addresses_idx;"
    execute "drop index further_info_idx;"
    execute "drop index supplementary_info_idx;"
    execute "drop index system_name_idx;"
    execute "drop index system_number_idx;"
    execute "drop index security_idx;"
    execute "drop index location_idx;"
    execute "drop index manager_idx;"
    execute "drop index authority_idx;"
    execute "drop index purpose_idx;"
    execute "drop index categories_of_individuals_idx;"
    execute "drop index categories_of_record_idx;"
    execute "drop index source_idx;"
    execute "drop index routine_uses_idx;"
    execute "drop index storage_idx;"
    execute "drop index retrieval_idx;"
    execute "drop index retention_idx;"
    execute "drop index safeguards_idx;"
    execute "drop index access_idx;"
    execute "drop index contesting_idx;"
    execute "drop index notification_idx;"
    execute "drop index exemptions_idx;"
    execute "drop index history_idx;"
  end
end
