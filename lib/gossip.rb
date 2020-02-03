class Gossip
	attr_accessor :author, :content
	def initialize(name, content)
		@author = name
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
		gossip_id = Array.new
		CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
	  		if (id == (index + 1))
				gossip_id << Gossip.new(csv_line[0], csv_line[1])
				return gossip_id
			end
		end
	end

	def self.update(id, gossip)
		id = id.to_i - 1
		all_gossips = self.all
		all_gossips[id] = gossip
		CSV.open("./db/gossip.csv", "w") do |csv|
			all_gossips.each do |gossip|
				csv << [gossip.author, gossip.content]
			end
		end
	end  
end