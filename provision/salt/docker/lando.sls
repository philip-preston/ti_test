Lando:
  pkg.installed:
    - enablerepo: ti-yum
    - name: lando
    - require:
        - file: TI Nexus Repo Install
        - pkg: Docker-CE
