#!/usr/bin/ruby

if ARGV == []
	puts "
USAGE: sudo ./install.rb <ARGS>

-i		Install/update dumpnwpass.
-r		Remove dumpnwpass.
	"
	abort
end

(puts "CAN HAZ R00T KTHXBYE!!1!11!!";abort) if ENV['USER'] != "root"

case ARGV[0]
	when "-i"
		if File.exist?("/bin/dumpnwpass")
			require 'net/http'
			File.open("/bin/dumpnwpass") do |f|
				f << Net::HTTP.get(URI("https://raw.githubusercontent.com/sesshomariu/dumpnwpass/master/dumpnwpass.rb"))
			end
		else
			if File.exist?("dumpnwpass.rb")
				print `sudo cp dumpnwpass.rb /bin/dumpnwpass; sudo chmod +x /bin/dumpnwpass`
			else
				begin
					File.open("dumpnwpass.rb") do |f|
						f << Net::HTTP.get(URI("https://raw.githubusercontent.com/sesshomariu/dumpnwpass/master/dumpnwpass.rb"))
					end
					print `sudo cp dumpnwpass.rb /bin/dumpnwpass; sudo chmod +x /bin/dumpnwpass`
				rescue
					puts "You need a network connection!"
					abort
				end
			end
		end
	when "-r"
		File.exist?("/bin/dumpnwpass") ? print(`sudo rm /bin/dumpnwpass`) : (puts("dumpnwpass wasn't installed."))
end
