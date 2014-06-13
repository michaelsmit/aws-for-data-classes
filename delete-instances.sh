# These commands require that you install the AWS command line tools.
# http://aws.amazon.com/cli/


# The output of describe-db-instances wants to include tons of additional data about each DB.
# default is JSON, but you can specify TEXT or TABLE which are a bit easier to script

#   aws rds describe-db-instances --output=text

# The output for text looks something like this:
#  
# Warning: next line is a very long line:
# DBINSTANCES	5	True	us-east-1b	0	db.t1.micro	<InstanceID>	available	<DBNAME>	mysql	5.6.13	2014-02-28T01:52:35.459Z		general-public-license	<ADMINUSER>	False	03:46-04:16	tue:04:38-tue:05:08	True
# DBPARAMETERGROUPS	default.mysql5.6	in-sync
# DBSECURITYGROUPS	default	active
# ENDPOINT	endpoint.com	3306
# OPTIONGROUPMEMBERSHIPS	default:mysql-5-6	in-sync


# The following mini-script gets all databases and deletes them
# NOTE: There is no confirmation, and all instances in the Region are deleted.
# You can instead just generate the commands with this script, and
# then remove the commands deleting instances you'd like to keep.
# alternatively, the "grep -v" portion allows you to exclude a single DB name;
# for example, your own test DB.

for i in `aws rds describe-db-instances --output=text | grep DBINSTANCES | grep -v OneDatabaseNotToDelete | cut -f 7`
  do echo aws rds delete-db-instance --db-instance-identifier=$i --skip-final-snapshot 
  # UNCOMMENT BELOW LINE TO ACTUALLY DELETE THE DB
  # aws rds delete-db-instance --db-instance-identifier=$i --skip-final-snapshot
done
