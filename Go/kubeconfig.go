package main

import "fmt"
import "flag"
import "path/filepath"
import "k8s.io/client-go/util/homedir"

func main() {
fmt.Println("1")
var kubeconfig *string
fmt.Println("2")
if home := homedir.HomeDir(); home != "" {
fmt.Println("3"+home)
	kubeconfig = flag.String("kubeconfig", filepath.Join(home, ".kube", "config"), "(optional) absolute path to the kubeconfig file")
fmt.Println("4")
} else {
fmt.Println("5")
	kubeconfig = flag.String("kubeconfig", "", "absolute path to the kubeconfig file")
fmt.Println("6")
}
fmt.Println("7")
flag.Parse()
fmt.Println("8")
fmt.Println(kubeconfig)
}
