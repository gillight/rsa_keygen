#!/bin/sh
program_name="gillight RSA keygen"
rsa_key_size=1024
ssh_keygen_quiet=""
phrass_default="keygen"
key_name_prefix=$(whoami)@$(hostname -f)
output_dir="$(pwd)/tmp3"
mkdir -p "${output_dir}"
ssh-keygen ${ssh_keygen_quiet} -b "${rsa_key_size}" -t "rsa" -N "${phrass_default}" -C "create by ${program_name}" -f "${output_dir}/${key_name_prefix}.id_rsa"
openssl pkcs8 -in "${output_dir}/${key_name_prefix}.id_rsa" -topk8  -passin "pass:${phrass_default}" -passout "pass:${phrass_default}" -out "${output_dir}/${key_name_prefix}.pk8"
