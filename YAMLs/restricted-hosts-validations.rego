package kubernetes.admission

import data.kubernetes.namespaces

operations = {"CREATE", "UPDATE"}

deny[msg] {
	input.request.kind.kind == "Ingress"
	operations[input.request.operation]
	host := input.request.object.spec.rules[_].host
	fqdn_matches_any(host, restricted_ingress_hosts)
	msg := sprintf("restricted ingress host %q", [host])
}

restricted_ingress_hosts = {host |
	blacklist := "tmp.example.com,*.example.com"
	hosts := split(blacklist, ",")
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
