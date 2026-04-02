# Analisador de Fanout (Conexoes de Sinais)
# Este script identifica todas as nets e conta quantas entradas cada uma alimenta.

# 1. Leitura do arquivo netlist.v
if {[catch {open "netlist.v" r} fp]} {
    puts "Erro: Arquivo 'netlist.v' não encontrado."
    exit
}
set conteudo [read $fp]
close $fp

# Criamos um array (como um dicionario) para guardar o nome da net e sua contagem
array set fanout {}

puts "Analisando Conexoes"

# Verifica as conexões
set conexoes [regexp -all -inline {\((\w+)\)} $conteudo]

# Contagem de Fanout e guarda em match
foreach {match net} $conexoes {
    
    # Ignora bits constantes
    if {[string match "*'b*" $net]} { continue }
    
    # Se a net já existe no array, incrementam o valor (fanout)
    # Se não existe, iniciam com 1
    if {[info exists fanout($net)]} {
        incr fanout($net)
    } else {
        set fanout($net) 1
    }
}

# Geracao do Relatório TOP 10
puts "\n--- TOP 10 NETS POR FANOUT ---"

# Transforma o array em uma lista para poder ordenar
set lista_ordenada {}
foreach nome [array names fanout] {
    lappend lista_ordenada [list $nome $fanout($nome)]
}

# Ordena de forma decrescente (-decreasing) baseada no valor numérico (-integer)
set lista_ordenada [lsort -integer -decreasing -index 1 $lista_ordenada]

# Imprime os 10 primeiros resultados
set i 0
foreach item $lista_ordenada {
    if {$i >= 10} break
    puts "[lindex $item 0]: fanout = [lindex $item 1]"
    incr i
}

# Identifica possiveis erros
puts "\n--- NETS COM FANOUT BAIXO (POSSÍVEIS ERROS) ---"
foreach item $lista_ordenada {
    # Se uma net aparece apenas 1 vez, ela pode estar "flutuando" (sem destino)
    if {[lindex $item 1] == 1} {
        puts "[lindex $item 0] (Apenas 1 conexão encontrada - verifique se está flutuando)"
    }
}
