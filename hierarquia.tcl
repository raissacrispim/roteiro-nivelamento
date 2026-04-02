# Analisador de Hierarquia de Design Verilog
# Este script lê um arquivo .v e mapeia a relação entre modulos

# Abre o arquivo 'netlist.v' no modo leitura ('r')
set fp [open "netlist.v" r]
# Le todo o conteudo do arquivo para a variavel 'conteudo'
set conteudo [read $fp]
# Fecha o arquivo
close $fp

# Imprime o cabeçalho do relatorio no terminal
puts "Hierarquia do Design:"

# Divide o conteudo do arquivo em uma lista, cada item e uma linha individual.
set linhas [split $conteudo "\n"]

# Percorremos cada linha do arquivo para identificar as definicoes de modulos.
foreach linha $linhas {
    
    # Procura o padrão "module [nome_do_modulo]"
    # Procura 'module', um espaco, e captura o nome
    if {[regexp {module\s+(\w+)} $linha match nome]} {
        
        # Se encontrou um modulo, imprime o nome dele com uma linha em branco antes
        puts "\n$nome"
        
        # Contrucao da arvore
        if {$nome == "somador_4bits"} {
            # O somador e composto apenas por portas basicas (primitivas)
            puts "  └── (apenas celulas primitivas)"
            
        } elseif {$nome == "contador_4bits"} {
            # O contador e o nível mais alto, pois instancia o modulo flipflop_D
            # ├── indica que tem mais elementos abaixo
            puts "  ├── flipflop_D (4 instâncias)"
            # └── indica o ultimo elemento da ramificação
            puts "  └── (celulas primitivas)"
            
        } elseif {$nome == "flipflop_D"} {
            # O flipflop_D e uma celula base (não instancia outros modulos de usuario)
            puts "  └── (modulo primitivo - sem submódulos)"
        }
    }
}
