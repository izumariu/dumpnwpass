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
		puts `sudo wget -O /bin/dumpnwpass 'https://raw.githubusercontent.com/sesshomariu/dumpnwpass/master/dumpnwpass.rb';sudo chmod +x /bin/dumpnwpass`
	when "-r"
		puts `sudo rm /bin/dumpnwpass`
end
