### Terraform-module-mongo

A terraform module for creating a mongo replica set that is kind of self healing. If an individual member dies, the auto scale group should relaunch it and it should rejoin automagically.

### Requirements

- Base ami (ubuntu, untested with anything else)
- Mongodb installed and configured
- EBS volume available at /dev/xvdg
- Name prefixed with `mongo-`

### Initial Setup

Just adding following command below and waiting a moment:

```
terraform init
terraform plan
terraform apply

```

### Note EBS store

Because we use template cloud to mount ebs into /mnt/db so that we need change permission for it

```
chown mongodb:mongodb /mnt/db/mongodb/

```

### Log rotate for mongodb

Rotate the log file by issuing the logRotate command from the admin database in a mongo shell:

```
use admin
db.adminCommand( { logRotate : 1 } )

```

###

```
cfg = rs.conf()
cfg.members = [cfg.members[0] , cfg.members[1] , cfg.members[2]]
rs.reconfig(cfg, {force : true})


### Refer

- https://docs.mongodb.com/manual/tutorial/rotate-log-files/
- https://ash.berlintaylor.com/writings/2017/08/reusable-terraform-modules-extending-userdata/
- https://stackoverflow.com/questions/43633329/mongodb-log-can-i-empty-this-file-without-error
- https://docs.mongodb.com/manual/tutorial/reconfigure-replica-set-with-unavailable-members/
- https://github.com/cgomestw/tf-mongodb-replica/blob/master/modules/cluster/scripts/bootstrap-replset.sh