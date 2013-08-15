http = require "http"
url = require "url"

myMongo = require "./mongo"

onRequest = (request, response) ->

	response.writeHead 200,
		"Content-Type": "text/plain"
			
	mongoConnet = new myMongo(response)
	if(request.method is 'POST')
		body = '';
		request.on 'data',  (data) ->
			body += data

		request.on 'end', () ->
			POST =  JSON.parse (body)
			mongoConnet.save(POST)

	else if(request.method is 'GET')
		mongoConnet.find()

server = http.createServer()
server.on("request", onRequest)
server.listen(8888)

console.log "Server up and Ready to eat"

#curl -i -X POST -H "Content-Type: application/json" -d '{"name":"brian","code":"sandwich"}' localhost:8888
#curl -i localhost:8888