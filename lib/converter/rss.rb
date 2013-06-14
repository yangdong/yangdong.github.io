# To run this:
#
# ./bloggerImport.sh blogname
#
# or
#
# git clone https://github.com/mojombo/jekyll
# cd jekyll
# wget https://raw.github.com/gist/1807781/rss.rb -O lib/jekyll/converters/rss.rb
#  or
# curl https://raw.github.com/gist/1807781/rss.rb -o lib/jekyll/converters/rss.rb
#
# wget "http://${BLOGGER}.blogspot.com/feeds/posts/full?alt=rss&max-results=500" -O ${BLOGGER}.xml
#  or
# curl "http://${BLOGGER}.blogspot.com/feeds/posts/full?alt=rss&max-results=500" -o ${BLOGGER}.xml
#
# mkdir _posts
# ruby -r './lib/jekyll/converters/rss' -e 'Jekyll::RSS.process("'${BLOGGER}'.xml")'
#
# Originally forked from ab36f4575d221db932facfe84daca9a224885fe4
# and from article at http://coolaj86.info/articles/migrate-from-blogger-to-jekyll.html

module Jekyll

  require 'rexml/document'
  require 'time'
  require "yaml"

  module RSS
    #Reads posts from an RSS feed.
    #It creates a post file for each entry in the RSS.
    def self.process(source = "yangdong.rss")
      #FileUtils.mkdir_p "_posts"
      content = ""
      open(source, "r") { |f| content << f.read }
      doc = REXML::Document.new(content)
      posts = 0
      doc.elements.each("feed/entry") do |item|
        categories = []
        link = item.elements["link"].attributes['href']
		permalink = link[link.index('/',7)..-1]

        # Use the URL after the last slash as the post's name
        name = link.split("/")[-1]
        
        # Remove html extension
        name = $1 if name =~ /(.*)\.html/

        # Remove the leading digits and dash that Serendipity adds
        name = $1 if name =~ /^\d+\-(.*)/

        title = item.elements["title"].text

	    #title = $1 if title =~ /\[.+\] (.+)/

        content_element = (item.elements["content"] or item.elements["description"])
        unless content_element
          puts "No content in RSS item '#{name}'\n"
          next
        end
        content = content_element.text
        timestamp = Time.parse(item.elements["published"].text)
        filename = "_posts/#{timestamp.strftime("%Y-%m-%d")}-#{name}.html"
        puts "#{link} -> #{filename}"
        File.open(filename, "w") do |f|
          YAML.dump(
            {
              "layout" => "post",
              "name" => name,
              "title" => title,
              "date" => timestamp,
		"categories" => categories,
		"permalink" => permalink,
            },
            f
          )
          f.puts "---\n#{content}"
        end
        posts += 1
      end
      puts "Created #{posts} posts!"
    end
  end
end
