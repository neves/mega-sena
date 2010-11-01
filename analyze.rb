require 'pp'
count = {}
sorteios = []
sorteios_num = []
for line in open("numeros.txt")
	parts = line.split %r(\D+)
	parts.map! &:to_i
	numeros = parts[1..-1]
	sorteios_num << numeros
	sorteios << parts
	#sorteio, n1, n2, n3, n4, n5, n6
	numeros.each do |n|
		count[n] = 0 unless count[n]
		count[n] += 1
	end
end

count.each do |k, v|
	printf("%02d%s\n", k, "="*v)
end
puts
count.keys.sort.each do |k|
	printf("%02d%s\n", k, "="*count[k])
end
puts
count.values.sort.reverse.each do |v|
	printf("%03d%s\n", v, "="*v)
end

ordem = count.map{|k,v| [k,v]}.sort{|a,b| a.last <=> b.last}
puts
ordem.each do |k, v|
	printf("%02d%s\n", k, "="*v)
end
=begin
mask = "%04s|" + "%02s " * 60 + "\n"
printf(mask,"" ,*1..60)

sorteios.reverse[200..500].each do |numeros|
	todos = (1..60).to_a
	todos.fill("")
	sorteio = numeros.shift
	numeros.each {|n|todos[n-1] = "[]"}
	printf(mask,sorteio ,*todos)
end

# mostra as quinas repetidas
sorteios.each_with_index do |v, k|
	sorteios[(k+1)..-1].each do |c|
		v1 = v.dup
		c1 = c.dup
		s1 = v1.shift
		s2 = c1.shift
		pp("#{s1}==#{s2}", v1, c1) if (v1 & c1).length == 5
	end
end
=end

puts "todos impares"
sorteios.each do |parts|
  parts = parts.dup
  sorteio = parts.shift
  pp sorteio, parts if parts.all? &:odd?
end

puts "todos pares"
sorteios.each do |parts|
  parts = parts.dup
  sorteio = parts.shift
  pp sorteio, parts if parts.all? &:even?
end

class Fixnum
  def prime?
    return false if self <= 1
    return true if self <= 3
    min = Math.sqrt(self).ceil
    2.upto(min) do |d|
      return false if self % d == 0
    end
    true
  end

  def dezena
    (self/10).round
  end
end

puts "todos primos"
sorteios.each do |parts|
  parts = parts.dup
  sorteio = parts.shift
  pp sorteio, parts if parts.all? &:prime?
end

puts "na mesma dezena"
sorteios.each do |parts|
  parts = parts.dup
  sorteio = parts.shift
  pp sorteio, parts if parts.reduce(true) {|b, v| b && v.dezena == parts.first}
end

puts "em cada dezena"
sorteios.each do |parts|
  parts = parts.dup
  sorteio = parts.shift
  pp sorteio, parts if parts.collect(&:dezena) == [0,1,2,3,4,5]
end

exit

(0..255).each do |n|
	c = n.chr
	puts "#{n}=#{c}"
end

#pp count