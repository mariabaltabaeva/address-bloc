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
    p "6 - Demolish all entries"
    p "7 - Exit"
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
      system "clear"
      demolish
      main_menu
    when 7
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
    print "Search by name: "
    name = gets.chomp
    # #10
    match = address_book.binary_search(name)
    system "clear"
    # #11
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    # #1
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # #2
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # #3
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
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

  def demolish
    system "clear"
    p "Are you sure?"
    p "y - yes"
    p "n - no"

    selection = gets.chomp

    case selection
    when "y"
      delete_all_entries
    when "n"
      system "clear"
      main_menu
    end
  end

  def delete_all_entries
    address_book.entries.clear
    p "You deleted all entries"
    main_menu
  end
end

def entry_submenu(entry)
  p "n - next entry"
  p "d - delete entry"
  p "e - edit this entry"
  p "m - return to main menu"

  selection = gets.chomp

  case selection
  when "n"
  when "d"
    delete_entry(entry)
  when "e"
    edit_entry(entry)
    entry_submenu(entry)
  when "m"
    system "clear"
    main_menu
  else
    system "clear"
    p "#{selection} is not a valid input"
    entry_submenu(entry)
  end
end

def delete_entry(entry)
  address_book.entries.delete(entry)
  puts "#{entry.name} has been deleted"
end

def edit_entry(entry)
  print "Updated name: "
  name = gets.chomp
  print "Updated phone number: "
  phone_number = gets.chomp
  print "Updated email: "
  email = gets.chomp
  entry.name = name if !name.empty?
  entry.phone_number = phone_number if !phone_number.empty?
  entry.email = email if !email.empty?
  system "clear"
  puts "Updated entry:"
  puts entry
end

def search_submenu(entry)
  # #12
  puts "d - delete entry"
  puts "e - edit this entry"
  puts "m - return to main menu"
  # #13
  selection = gets.chomp

  # #14
  case selection
  when "d"
    system "clear"
    delete_entry(entry)
    main_menu
  when "e"
    edit_entry(entry)
    system "clear"
    main_menu
  when "m"
    system "clear"
    main_menu
  else
    system "clear"
    puts "#{selection} is not a valid input"
    puts entry.to_s
    search_submenu(entry)
  end
end
