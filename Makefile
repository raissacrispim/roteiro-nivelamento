# Variaveis
TCL_SCRIPT = gerador_relatorio.tcl
SHELL_SCRIPT = projeto.sh
RELATORIO = relatorio_final.txt

# Alvo padrão
all: pasta_projeto $(RELATORIO)

# Regra para o relatorio (só roda se o arquivo não existir)
$(RELATORIO): $(TCL_SCRIPT)
	@echo "Gerando relatorio final..."
	tclsh $(TCL_SCRIPT) > $(RELATORIO)

# Regra para organizar pastas
pasta_projeto: $(SHELL_SCRIPT)
	@echo "Executando organizacao de pastas..."
	./$(SHELL_SCRIPT)

# Limpeza
clean:
	@echo "Limpando arquivos..."
	rm -f $(RELATORIO)
