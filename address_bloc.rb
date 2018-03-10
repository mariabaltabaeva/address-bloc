require_relative 'controllers/menu_controller'

 menu = MenuController.new
 system "clear"
 p "Welcome to AddressBloc!"
 menu.main_menu
