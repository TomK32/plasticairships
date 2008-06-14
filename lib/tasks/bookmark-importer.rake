namespace :bookmarks do
  desc "Import new booksmarks from services"
  task(:import => :environment) do
    Mirrored::Base.establish_connection(:delicious, '', '')
    puts y Mirrored::Post.find(:get, :tag => 'ruby', :user => 'TomK32')
  end
end