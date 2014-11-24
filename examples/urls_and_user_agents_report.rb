require 'rolltools'

Rolltools::Settings.settings = { 'read_token' => 'abc123'} #replace w/ your token

items = Rolltools::Utils.get_items('3002').first(10)
items += Rolltools::Utils.get_items('3003').first(10)
grouped = items.group_by{|u|u[:url]}

puts "<html><body><ul>"
grouped.sort_by{|k,v|v.length}.reverse.each do |k,v| 

  puts "\n<li><span title=\"#{k}\">#{k[0..100]}</span>: #{v.length}"
  puts "<ul>"
  v.group_by{|r|r[:user_agent]}.sort_by{|k2,v2|v2.length}.reverse.each do |k2,v2|
    puts "\t<li><span title=\"#{k2}\">#{k2[0..100] rescue 'none'}</span>: #{v2.length}</li>"
  end
  puts "</ul></li>"

end
puts "</ol></body></html>"

