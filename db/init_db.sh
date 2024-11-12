#!/bin/sh

echo "Initializing MySQL db"
mysql -u root -p$MYSQL_ROOT_PASSWORD --execute \
  "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';"

mysql -u root -p$MYSQL_ROOT_PASSWORD --execute \
  "FLUSH PRIVILEGES;"

echo "MySQL db initialized correctly"