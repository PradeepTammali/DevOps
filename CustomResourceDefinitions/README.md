Kube builder create new CRD steps:

1. Initialization steps
go mod init pradeep/k8s/io
kubebuilder init --domain k8s.io
kubebuilder create api --group pradeep --version v1alpha1 --kind MapRTicket
kubebuilder create webhook --group pradeep --version v1alpha1 --kind MapRTicket --defaulting --programmatic-validation
 env variabels for MapRTicket 
	DEFAULT_USERID
	DEFAULT_USERNAME
	DEFAULT_GROUPID
	DEFAULT_USERNAME

