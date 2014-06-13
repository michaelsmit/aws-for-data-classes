# These commands require that you install the AWS command line tools.
# http://aws.amazon.com/cli/


# The output of describe-db-snapshots wants to include tons of additional data about each DB.
# default is JSON, but you can specify TEXT or TABLE which are a bit easier to script

#   aws rds describe-db-snapshots --output=text

# The output for text looks something like this:
#  
# Warning: next line is a very long line:
# DBSNAPSHOTS	5	us-east-1b	<DB_INSTANCE_ID>	<DB_SNAPSHOT_ID>	mysql	5.6.13	2014-02-24T02:24:28.348Z	general-public-license	<ADMIN_USER_NAME>	default:mysql-5-6	100	3306	2014-04-14T13:35:07.126Z	manual	available
# 
# Note text like <CAPS> will be filled in with actual values.
# 
# This command *includes* auto backup snapshots for any not-deleted databases.
# A trivial modification will delete only final-snapshots.

# The following mini-script gets all snapshots and deletes them
# NOTE: There is no confirmation, and all snapshots in the Region are deleted.
# You can instead just generate the commands with this script, and
# then remove the commands deleting snapshots you'd like to keep.

for i in `aws rds describe-db-snapshots --output=text | grep DBSNAPSHOTS | cut -f 5`
  do echo aws rds delete-db-snapshot --db-snapshot-identifier=$i
  # UNCOMMENT BELOW LINE TO ACTUALLY DELETE THE snapshot
  # aws rds delete-db-snapshot --db-snapshot-identifier=$i
done
