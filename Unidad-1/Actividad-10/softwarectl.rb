#!usr/bin/env ruby
# encoding: utf-8

puts "Dispones de 4 comandos: "
puts " - El comando --help mostrará la ayuda"
puts " - El comando --version mostrará el autor del script y la fecha de creación"
puts " - El comando --status FILENAME lee el contenido de un archivo y muestra su estado"
puts " - El comando --run FILENAME comprueba que somos root y ejecuta una acción"

print "escribe un comando: "
comando = gets.chop

if comando == ""
    puts "porfavor ingresa un comando que se encuentre en la lista"
end

if comando == "--help"
puts "Usage:
        systemctml [OPTIONS] [FILENAME]
Options:
        --help, mostrar esta ayuda.
        --version, mostrar información sobre el autor del script
                   y fecha de creacion.
        --status FILENAME, comprueba si puede instalar/desintalar.
        --run FILENAME, instala/desinstala el software indicado.
Description:

        Este script se encarga de instalar/desinstalar
        el software indicado en el fichero FILENAME.
        Ejemplo de FILENAME:
        tree:install
        nmap:install
        atomix:remove"
end

if comando == "--version"
    puts "El creador del script es Lucas Hernández"
    puts "Nos encontramos en curso2021"
end

if comando == "--status"
    a = `cat FILENAME.txt`
    b = a.split("\n")
    b.each do |i|
        c= i.split(":")
        d = `whereis #{c[0]}|grep bin|wc -l`.chop
        if d == "1"
        puts "*El paquete #{c[0]}está instalado"
        else
        puts "*El paquete #{c[0]} no está instalado"
        end
    end
end


if comando == "--run"
    root = `whoami | grep root | wc -l`.chop
    if root == "1"
        a = `cat FILENAME`
        b = a.split("\n")
        b.each do |i|
        c = i.split(":")
        d = "#{c[1]}"
        if d == "install"
            `zypper #{c[1]} -y #{c[0]}`
            puts "#{c[0]} instalado"
        else
            `zypper #{c[1]} -y #{c[0]}`
            puts "#{c[0]} borrado}"
        end
        end
    else
        puts "tienes que ser root"
        exit 1
    end
end
