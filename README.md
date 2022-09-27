# concourse-via-ansible
Deploy Concourse via Ansible

[![Repo](https://img.shields.io/static/v1?style=for-the-badge&logo=github&logoColor=white&label=repo&message=0.1.3&color=blue)](https://github.com/DonBower/concourse-via-ansible)
[![Concourse](https://img.shields.io/static/v1?style=for-the-badge&logo=concourse&logoColor=white&label=concourse&message=7.8.2&color=blue)](https://concourse-ci.org)
[![Ansible](https://img.shields.io/static/v1?style=for-the-badge&logo=ansible&logoColor=white&label=ansible&message=2.13.2&color=blue)](https://concourse-ci.org)
[![Ubuntu](https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&logoColor=white&label=ubuntu&message=20.04_LTS&color=blue)](https://ubuntu.com/download/server)
[![issues](https://img.shields.io/static/v1?style=for-the-badge&label=issues&message=1&color=blue)](https://github.com/DonBower/concourse-via-ansible/issues)

# Prerequisits:
1. a hosts file with the following:
```yaml
concourseCluster:
  vars:
    debugLevel: 0
    needConcourseBin: false
    dbServer: false
    concourseServer: false
    concourseWorker: false
    needConcourseKeys: false
    concourseKeysDir: /home/concourse/.ssh
    concourseVersion: 7.8.2
    postgresMajorVersion: 12
    postgresMinorVersion: 12
    concourseDownloadURL: https://github.com/concourse/concourse/releases/download
    concourseBinDir: /usr/local
  children:
    concourse:
    workers:
    postgres:
    ansibleHost:

ansibleHost:
  children:
    alias-to-ansible-host:

postgres:
  hosts:
    fqdn-to-db-host:
       dbServer: true

concourse:
  vars:
    needConcourseBin: true
    needConcourseKeys: true
    concourseServer: true
  hosts:
    fqdn-to-concourse-web-server-host:

workers:
  vars:
    needConcourseBin: true
    concourseWorker: true
  hosts:
    fqdn-to-first-worker-host:
    fqdn-to-second-worker-host:
    ...

alias-to-ansible-host:
  vars:
    ansible_connection: local
  hosts:
    fqdn-to-ansible-host:
```

Another file required is `~/.ssh/avpw`
this is a file that contains a password, used for ansible vault.
Be very carefull about changing the content of this file.  ALL of your ansible-vault protected file must first be decrypted before you change this value, otherwise the information is lost forever.


You also need a `~/.ssh/concourseSecrets.yaml` file that looks like this:
```yaml
---
remoteUser: <your userid on remote hosts>
concoursePassword: <a password for Concourse user>
concourseFQDN: <fqdn-to-concourse-web-server-host>
postgresFQDN: <fqdn-to-db-host>
```

once you have created this file, encrypt it with `./encryptSecrets.sh`.
