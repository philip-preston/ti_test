Create docker group:
  group.present:
    - name: docker
    - system: True
    - members:
      - vagrant

Upgrade selinux:
  pkg.installed:
    - enablerepo: ti-yum
    - name: container-selinux
    - require:
        - file: TI Nexus Repo Install

Docker-CE:
  cmd.run:
    - name: sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    - reqire_in:
      - pkg: docker-ce
    - unless: docker --version
  pkg.installed:
    - name: docker-ce
    - refresh: True
