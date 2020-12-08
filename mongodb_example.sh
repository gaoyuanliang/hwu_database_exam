brew install mongodb

sudo chown -R `id -un` /data/db

mongo

use hw

show collections

wget www.macs.hw.ac.uk/~pb56/labData.json

less labData.json

mongoimport –d hw \
-c hwuPeople \
-f labData.json 

db.hwuPeople.find()
