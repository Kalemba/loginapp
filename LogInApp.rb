class Interface
	def start
		p "Zaloguj sie - z"
		p "Zarejestruj sie - r"
		command = gets.chomp
		case command
			r = "r"
			z = "z"
		when z
			p "Podaj nazwe uzytkownika:"
			user = gets.chomp
			p "Podaj haslo:"
			pass = gets.chomp

			unless log_in(user, pass).nil? {
				current_user = log_in(user, pass)
				return user_interface
			}
		end
		when r
			create_user
			return start
		end
		else
			p "Nieznana komenda."
			return start
		end
	end

	def user_interface
		p "Pokaz pliki - p \nStworz nowy plik - s \nUsun plik - u\nWyloguj - w"
		user_command = gets.chomp
		case user_command
		when "p"
			current_user.show_files
		when "s"
			current_user.create_file
		when "u"
			current_user.delete_file
		when "w"
			log_out
		else
			p "Nieznana komenda."
			return user_interface
		end


	end

	def log_out
		current_user = nil
		return start
	end

end

class Account

	public

		def log_in(user, pass)
			if @@user_pass[user] == pass
				return @@users_accounts[user]
			else
				err_log_in
				return nil
			end

		end

		def create_user
			p "Podaj nazwe dla nowego uzytkownika:"
			username = gets.chomp
			if @@user_pass.key?(username)
				p "Nazwa uzytkownika istnieje. Prosze wybrac inna."
			else
				p "Podaj haslo dla nowego uzytkowniak:"
				pass_1 = gets.chomp
				p "Powtorz haslo:"
				pass_2 = gets.chomp
				if pass_1 == pass_2
					users_accaunts[username] = Account.new(username, pass_1)
				else
					p "Blad hasla, podane hasla sa rozne! Sprobuj ponownie."
					return create_user
				end
			end
			return nil

		end

		def show_files
			p "Pliki uzytkownika #{@user}:"
			@files.each {|x, y| p "#{x}\n #{y}\n\n"}
		end

		def create_file
			p "Podaj nazwe pliku:"
			file_name = gets.chomp
			p "Podaj tersc pliku:"
			text = gets.chomp
			@files[file_name] = text 

		end

		def delete_file
			p "Podaj nazwe pliku do usuniecia:"
			file_name = gets.chomp
			p "Potwierdz usuniecie swoim haslem:"
			password = gets.chomp
			if @files.key(file_name) && password == @pass 
				@files.delete(file_name)
			elsif pass != @pass
				p "Haslo niepoprawne!"
				return user_interface
			else
				p "Nie ma takiego pliku!"
				return user_interface
			end

		end

		def err_log_in
			p "Niepoprawna nazwa uzytkownika, badz haslo!"

		end

	private
		@@user_pass = {}
		@@users_accounts ={}

		def initialize(user, pass)
			@user = user
			@pass = pass
			@@user_pass[@user] = @pass 
			@files = {}
		end







end
start
