#!/bin/sh
program_name="gillight RSA keygen"
rsa_key_size=1024
ssh_keygen_quiet=""
phrass_default=""
key_name_prefix=$(whoami)@$(hostname -f)
output_dir="$(pwd)/tmp3"
mkdir -p "${output_dir}"
ssh-keygen ${ssh_keygen_quiet} -b "${rsa_key_size}" -t "rsa" -N "" -C "create by ${program_name}" -f "${output_dir}/${key_name_prefix}.id_rsa"
openssl pkcs8 -in "${output_dir}/${key_name_prefix}.id_rsa" -topk8 -nocrypt -out "${output_dir}/${key_name_prefix}.pk8"
openssl req -new -x509 -key "${output_dir}/${key_name_prefix}.pk8" -subj "/CN=${key_name_prefix}" -out "${output_dir}/${key_name_prefix}.cert.pem" 
openssl pkcs12 -export -in "${output_dir}/${key_name_prefix}.cert.pem" -inkey  "${output_dir}/${key_name_prefix}.pk8" -passout pass: -out "${output_dir}/${key_name_prefix}.p12"
cat "${output_dir}/${key_name_prefix}.id_rsa" | pem2openpgp ${key_name_prefix} > "${output_dir}/${key_name_prefix}.pgp"
