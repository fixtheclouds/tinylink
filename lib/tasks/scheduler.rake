desc 'Remove all links older than 15 days'
task remove_absolute_links: :environment do
  Link.where('created_at < ?', 15.days.ago).delete_all
end
