desc "Import old blog from cnblogs"
task :import do
  `wget http://feed.cnblogs.com/blog/u/83179/rss -O yangdong.rss`
  `ruby -r './lib/converter/rss.rb' -e 'Jekyll::RSS.process'`
end
