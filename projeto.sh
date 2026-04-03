#!/bin/bash
echo "Organizando pastas do projeto..."
mkdir -p scripts reports design
cp *.tcl scripts/ 2>/dev/null
cp netlist.v design/ 2>/dev/null
echo "Pastas criadas e arquivos movidos!"
