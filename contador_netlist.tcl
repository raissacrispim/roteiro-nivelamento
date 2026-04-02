# Abre o arquivo netlist.v para leitura
set fp [open "netlist.v" r]
set file_data [read $fp]
close $fp

# Contagem
set and2_count [regexp -all {AND2} $file_data]
set xor2_count [regexp -all {XOR2} $file_data]
set ff_count   [regexp -all {flipflop_D} $file_data]

# Calculo do total
set total [expr {$and2_count + $xor2_count + $ff_count}]

# Impressão do Relatorio
puts "Relatorio de Celulas:"
puts "AND2: $and2_count instancias"
puts "XOR2: $xor2_count instancias"
puts "flipflop_D: $ff_count instancias"
puts "TOTAL: $total instancias"
