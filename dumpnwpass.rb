#!/usr/bin/ruby
(puts "CAN HAZ R00T??? KTHXBYE!!11!";abort) if ENV['USER'] != "root"
$DEFPATH = "/etc/NetworkManager/system-connections/"
(puts "I can't find the folder with the passwords! Means your system is not affected :)";exit(0)) if !File.exist?($DEFPATH)
networks = `ls #{$DEFPATH}`.split("\n")
npass = Hash.new

$macs = false

ARGV.each_with_index do |arg, index|
	if arg == "-m"
		$macs = true
	end
end

$counts = [0,0]

def is_eth?(f)
	File.open("#{$DEFPATH}#{f}","r").each_line do |l|
		($counts[1]+=1;return true) if l.chomp=="type=ethernet"
	end
	false
end

def getPass(f)
	File.open("#{$DEFPATH}#{f}","r").each_line do |l|
		($counts[0]+=1;return l.chomp.split("psk=")[1]) if l.chomp.match(/^psk=.{1,}$/)
	end
	$counts[1]+=1
	"<[PROBABLY PUBLIC HOTSPOT WITH PAYWALL]>"
end

def getMac(f)
	return "" if !$macs
	File.open("#{$DEFPATH}#{f}","r").each_line do |l|
		($counts[0]+=1;return " | MAC = #{l.chomp.split("mac-address=")[1]}") if l.chomp.match(/^mac-address=.{1,}$/)
	end
end

networks.each do |n|
	if is_eth?(n)
		npass["#{n}#{getMac(n)}"] = "<[ETHERNET]>"
	else
		npass["#{n}#{getMac(n)}"] = getPass(n)
	end
end

counter = 0
npass.each_key{|k|counter=k.length if k.length>counter}
puts;npass.each_key{|k|(counter-k.length).times{print(" ")};puts("#{k} => #{npass[k]}")}
puts;puts("#{$counts[0]} passwords dumped, #{$counts[1]} fails, #{($counts[0]*100)/networks.length}% success")
