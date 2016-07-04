#!/usr/bin/ruby
(puts "CAN HAZ R00T??? KTHXBYE!!11!";abort) if ENV['USER'] != "root"
$DEFPATH = "/etc/NetworkManager/system-connections/"
(puts "Good job, I can't find the folder with the passwords! Means your system is not affected :)";exit(0)) if !File.exist?($DEFPATH)
networks = `ls #{$DEFPATH}`.split("\n")
npass = Hash.new

def is_eth?(f)
	File.open("#{$DEFPATH}#{f}","r").each_line do |l|
		return true if l.chomp=="[ethernet]"
	end
	false
end

def getPass(f)
	File.open("#{$DEFPATH}#{f}","r").each_line do |l|
		return l.chomp.split("psk=")[1] if l.chomp.match(/^psk=.{1,}$/)
	end
	"<[Probably public hotspot with paywall]>"
end

networks.each do |n|
	if is_eth?(n)
		npass[n] = "<[Ethernet]>"
	else
		npass[n] = getPass(n)
	end
end

counter = 0
npass.each_key{|k|counter=k.length if k.length>counter}
npass.each_key{|k|(counter-k.length).times{print(" ")};puts("#{k} => #{npass[k]}")}
