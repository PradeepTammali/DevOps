import yaml


yaml_data = '''apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: sample-ingress
  namespace: adtest1
spec:
  backend:
    serviceName: sample-app
    servicePort: 8088'''

print yaml_data
stream = open("sample.yaml","r")
resource_dicts = yaml.load_all(yaml_data)
for resource in resource_dicts:
    print resource

