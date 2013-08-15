class myMongo
	constructor: (@response)->
		databaseUrl = "mydb"
		collections = ["randomValues"]
		@db = require("mongojs").connect(databaseUrl, collections)
	
	save: (args) =>
		@db.randomValues.save(args, @_saveCallBack)
	
	_saveCallBack: (err, saved) =>
		if err?
			console.log(err)
			@response.write(err)
		else
			console.log("Saved #{JSON.stringify(saved)}")
			@response.write("will be saved")
		@response.end()
	
	find: =>
		@db.randomValues.find {}, @_findCallBack
	
	_findCallBack: (err, values) =>
	
		console.log "#{values.length} Requested"
		
		if err? 
			console.log err
		else if values.length is 0
			@response.write "No values found"
		else
			@response.write JSON.stringify(val)+"\n" for val in values
		@response.end()

module.exports = myMongo