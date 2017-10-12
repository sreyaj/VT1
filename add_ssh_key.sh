
export RES_GH_SSH="deep_gh_ssh"
export RES_GH_SSH_UP=$(echo $RES_GH_SSH | awk '{print toupper($0)}')
export RES_GH_SSH_META=$(eval echo "$"$RES_GH_SSH_UP"_META")

add_ssh_key() {
 pushd "$RES_GH_SSH_META"
 echo "Extracting SSH Key"
 echo "-----------------------------------"
 cat "integration.json"  | jq -r '.privateKey' > gh_ssh.key
 chmod 600 gh_ssh.key
 ssh-add gh_ssh.key
 echo "Completed Extracting SSH key"
 echo "-----------------------------------"
 popd
}

main() {
  add_ssh_key
  ssh ubuntu@ec2-54-89-188-192 'ls -al'
}

main
