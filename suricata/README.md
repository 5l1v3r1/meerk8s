# Suricata Container

Container definition for use in meerk8s.

Key facts:
 * _entrypoint.sh_: Starts suricata, listening on all promiscous ports
 * _etc/suricata/rules/local.rules_: Any locally-defined rules to include in the container
 * _etc/suricata/k8s-configmap.yaml_: Can be set using a kubernetes configmap to make config changes at runtime.
