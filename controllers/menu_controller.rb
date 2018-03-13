require_relative '../models/address_book'

class MenuController
   attr_reader :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu
     p "Main Menu - #{address_book.entries.count} entries"
     p "1 - View all entries"
     p "2 - Create an entry"
     p "3 - Search for an entry"
     p "4 - Import entries from a CSV"
     p "5 - View entry by number"
     p "6 - Exit"
     print "Enter your selection: "

     selection = gets.to_i

     case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
         system "clear"
         create_entry
         main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        system "clear"
        view_by_number
        main_menu
      when 6
        p "Good-bye"
        exit(0)
      else
        system "clear"
        p "Sorry, that is not a valid input"
        main_menu
   end
end

    def view_all_entries
      address_book.entries.each do |entry|
        system "clear"
        p entry.to_s
        entry_submenu(entry)
      end

      system "clear"
      p "End of entries"
    end

    def create_entry
      system "clear"
      p "New AddressBloc Entry"
      print "Name: "
      name = gets.chomp
      print "Phone number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp

      address_book.add_entry(name, phone, email)

      system "clear"
      p "New entry created"
    end

    def search_entries
    end

    def read_csv
    end

    def view_by_number
      system "clear"
      print "Entry number: "
      n = gets.chomp.to_i

      if n <= address_book.entries.length
       puts  address_book.entries[n-1].to_s
      else
        puts "It's not valid entry number"
        puts "Please enter valid"
        sleep 3
        view_by_number
      end
        #entry_submenu(entry)
    end

    def entry_submenu(entry)
      p "n - next entry"
      p "d - delete entry"
      p "e - edit this entry"
      p "m - return to maim menu"

      selection = gets.chomp

      case selection
      when "n"
      when "d"
      when "e"
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        p "#{selection} is not a valid input"
        entry_submenu(entry)
      end
    end
  end
