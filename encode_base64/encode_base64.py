import base64

username = "pradeep"
password = "~!@#$%^&*()_+`-={}|[]\;':,./<>?"

e_username = base64.b64encode(username)
e_password = base64.b64encode(password)
print "username encoded:"+e_username
print "password encoded:"+e_password

print "Decoding..."
print "username decoded:"+base64.b64decode(e_username)
print "password decoded:"+base64.b64decode(e_password)
