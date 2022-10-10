require_relative "room"

class Hotel
    attr_reader :rooms

    def initialize(name, roomsz)
        @name = name
        @rooms = {}
        roomsz.each do |k, v|
             @rooms[k] = Room.new(v) 
        end
    end

    def name
        @name.split.map { |n| n.capitalize}.join(" ")
    end
    
    def room_exists?(room_name)
        if @rooms.has_key?(room_name)
            return true
        else
            return false
        end
    end

    def check_in(person, room_name)
       if self.room_exists?(room_name)
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        else
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
        @rooms.values.any? { |room| room.available_space > 0 }
    end

    def list_rooms
        @rooms.each do |k, v|
            puts "#{k} : #{v.available_space}"
        end
    end

end
