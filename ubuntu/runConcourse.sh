#!/bin/bash
clear
echo $0 $@
thisUser=`whoami`
if [[ -f $1 ]]; then
    ansiblePlaybook=${1}
  else
    ansiblePlaybook=concourse.yaml
fi

if [[ ! -f ${ansiblePlaybook} ]]; then
  echo -e "The file ${ansiblePlaybook} was not found.  Please specify an existing playbook."
  exit 1
fi

if [[ -f $2 ]]; then
    ansibleBecome="--become-password-file $2"
  else
    ansibleBecome="--become-password-file ~/.ssh/sshpw"
fi

if [[ $DEBUG -gt 0 ]]; then
  echo -e "ansible-playbook \\"
  echo -e "  --user ${thisUser} \\"
  echo -e "  --vault-password-file ~/.ssh/avpw \\"
  echo -e "  ${ansibleBecome} \\"
  echo -e "  ${ansiblePlaybook}"
fi

ansible-playbook \
  --user ${thisUser} \
  --vault-password-file ~/.ssh/avpw \
  ${ansibleBecome} \
  ${ansiblePlaybook}
