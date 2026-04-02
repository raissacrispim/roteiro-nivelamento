# -----------------------------------------------------------
# TAREFA 4: Gerador de Relatório Completo (Amálgama)
# Este script une as funcionalidades de contagem, hierarquia e conexões.
# -----------------------------------------------------------

puts "========================================================="
puts "             RELATÓRIO TÉCNICO DE DESIGN EDA             "
puts "========================================================="

# Chama o script da Tarefa 1 (Contagem)
puts "\n>> ANÁLISE DE CÉLULAS:"
source contador_netlist.tcl

# Chama o script da Tarefa 2 (Hierarquia)
puts "\n>> ANÁLISE DE HIERARQUIA:"
source hierarquia.tcl

# Chama o script da Tarefa 3 (Conexões)
puts "\n>> ANÁLISE DE FANOUT:"
source estatisticas_conexoes.tcl

puts "\n========================================================="
puts "             FIM DO RELATÓRIO - CI EXPERT                "
puts "========================================================="
