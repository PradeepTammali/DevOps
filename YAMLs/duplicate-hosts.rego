package kubernetes.admission

import data.kubernetes.ingresses
import data.kubernetes.namespaces

operations = {"CREATE", "UPDATE"}

deny[msg] {
    some other_ns, other_ingress
    input.request.kind.kind == "Ingress"
    operations[input.request.operation]
    host := input.request.object.spec.rules[_].host
    ingress := ingresses[other_ns][other_ingress]
    other_ns != input.request.namespace
    ingress.spec.rules[_].host == host
    not fqdn_matches_any(host, valid_ingress_hosts)
    msg := sprintf("invalid ingress host %q (conflicts with %v/%v)", [host, other_ns, other_ingress])
}

valid_ingress_hosts = {host |
	whitelist := namespaces[input.request.namespace].metadata.annotations["ingress-whitelist"]
	hosts := split(whitelist, ",")
	host := hosts[_]
}

fqdn_matches_any(str, patterns) {
	fqdn_matches(str, patterns[_])
}

fqdn_matches(str, pattern) {
	pattern_parts := split(pattern, ".")
	pattern_parts[0] == "*"
	str_parts := split(str, ".")
	n_pattern_parts := count(pattern_parts)
	n_str_parts := count(str_parts)
	suffix := trim(pattern, "*.")
	endswith(str, suffix)
}

fqdn_matches(str, pattern) {
    not contains(pattern, "*")
    str == pattern
}
