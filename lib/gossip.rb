require 'csv'

class Gossip
	attr_accessor :author, :content
	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
  	CSV.open("./db/gossip.csv", "ab") do |csv|
    	csv << [@author, @content]
 		end
	end

	def self.all
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

	def self.find(id)
		id = id.to_i - 1
		gossip = self.all
		return gossip[id]
	end

	def self.update(id, author, content)
		all_gossips = Gossip.all
		id = id.to_i - 1
		all_gossips[id].author = author
		all_gossips[id].content = content
		n = 0
		a =  all_gossips.length
		CSV.open("./db/gossip.csv", "w")
		while a > 0
			CSV.open("./db/gossip.csv", "ab") do |csv|
	    	csv << [all_gossips[n].author, all_gossips[n].content]
	    end
			a -= 1
			n += 1
		end
	end
end