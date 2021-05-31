db = db.getSiblingDB('admin');
db.createUser(
    {
        user: "root",
        pwd: "root",
        roles:[
            {
                role: "userAdminAnyDatabase",
                db:   "admin"
            },
            {
                role: "dbAdminAnyDatabase",
                db:   "admin"
            },
            {
                role: "readWriteAnyDatabase",
                db:   "admin"
            },
            {
                role: "root",
                db:   "admin"
            }
        ]
   }
);
