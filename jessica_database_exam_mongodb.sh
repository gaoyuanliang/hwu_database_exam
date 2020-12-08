wget https://www.macs.hw.ac.uk/~pb56/f21dfexamdata2020/music/playlists.json
wget https://www.macs.hw.ac.uk/~pb56/f21dfexamdata2020/music/tracks.json

mongoimport --db hw  \
--collection tracks  \
--jsonArray  \
--drop  \
--file tracks.json

mongoimport --db hw  \
--collection playlists  \
--jsonArray  \
--drop  \
--file playlists.json

db.tracks.count()

db.tracks.find().pretty()

db.tracks.distinct("ArtistName", {$or: [{"ArtistName":/^The/i}, {"ArtistName":/^the/i}]}).length;

db.tracks.aggregate([ {$sortByCount: "$Genre"},{$limit:1}])


db.tracks.aggregate([{$group: {_id:"$Genre",average_track_length: {"$avg": '$Milliseconds'}}} ])


db.playlists.find().pretty()

db.tracks.aggregate([{$group: {_id:"$Genre",average_track_length: {"$avg": '$Milliseconds'}}} ])

db.tracks.aggregate([{$group: {_id:"$Genre",total: {"$sum": '$age'}}} ])

db.playlists.aggregate([ {$sortByCount: "$TrackId"},{$limit:1}])


db.tracks.distinct("TrackId").length;

db.tracks.aggregate([
{
   $lookup:
   {
       from: "playlists",
       localField: "TrackId",
       foreignField: "TrackId",
       as: "tracks_playlists"
   }
},
{ "$match": { "tracks_playlists.0": { "$exists": false } } }
]).pretty()