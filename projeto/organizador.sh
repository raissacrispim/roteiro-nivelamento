#!/bin/bash
# Organizador de diretorios com shell

# Move o script para a pasta projeto
cd "$(dirname "$0")" || exit

# Variavel de modo simulacao ou normal, normal = f e siulacao = t
DRY_RUN=false

# Verifica se o usuário passou o argumento --dry-run ao executar
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true                     # Ativa o modo simulac
    echo "Modo DRY-RUN ativado"      # Mostra mensagem no terminal
fi

move_file() {
    local src="$1"         # Nome do arquivo
    local dest_dir="$2"    # Pasta de destino

    # Verifica se o diretório não existe
    if [[ ! -d "$dest_dir" ]]; then
	# Mostra que vai criar a pasta
        echo "Criando diretório: $dest_dir"
	# Não executa nada, pois DRY_RUN e verdadeiro
        $DRY_RUN || mkdir -p "$dest_dir"
    fi
    # Verifica se já existe um arquivo com mesmo nome no destino
    if [[ -e "$dest_dir/$src" ]]; then
	# Avisa que ja existe e por isso nao move
        echo "Já existe, ignorando: $dest_dir/$src"
        return
    fi
    # Mostra exatamente o que está sendo feito
    echo "Movendo $src → $dest_dir/"
    # Executa o movimento
    $DRY_RUN || mv "$src" "$dest_dir/"
}

# Loop que percorre todos os arquivos da pasta atual
for file in *; do
    # Ignora o proprio arquivo para nao move-lo
    [[ -f "$file" && "$file" != "organizador.sh" ]] || continue

    ext="${file##*.}"         # Extrai a extensao
    name="${file%.*}"         # Extrai o nome sem extensao

    # Converte para minusculo
    ext="${ext,,}"
    name="${name,,}"

    # Se tem extensao .v e contem tb ou teste no nome, move para tb
    if [[ "$ext" == "v" && ( "$name" == *"_tb"* || "$name" == *"test"* ) ]]; then
        move_file "$file" "tb"

    # Senao teste se tem extensao .v e move para src
    elif [[ "$ext" == "v" ]]; then
        move_file "$file" "src"

    # Senao teste se tem extensao vh e move para include
    elif [[ "$ext" == "vh" ]]; then
        move_file "$file" "include"

    # Senao teste se tem extensao .tcl, .do ou .sh e move para scripts
    elif [[ "$ext" =~ ^(tcl|do|sh)$ ]]; then
        move_file "$file" "scripts"

    # Senao teste se tem extensao .md ou .txt e move para docs
    elif [[ "$ext" =~ ^(md|txt)$ ]]; then
        move_file "$file" "docs"
    fi
done
