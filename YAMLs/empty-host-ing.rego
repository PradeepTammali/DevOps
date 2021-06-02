package kubernetes.admission

operations = {"CREATE", "UPDATE"}

deny[msg] {
  some hosts
  input.request.kind.kind == "Ingress"
  operations[input.request.operation]
  validate_empty_host[hosts]
  not hosts.host
  msg := "host is required"
}

validate_empty_host[hosts] {
  hosts := input.request.object.spec.rules[_]
}
