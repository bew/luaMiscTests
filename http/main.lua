local Http = require "socket.http"

local request_body = [[login=user&password=123]]

local response_body = {}

local res, code, response_headers = Http.request {
	url = "https://intra.epitech.eu/";
	method = "GET";
	headers = {
		--["Content-Type"] = "application/x-www-form-urlencoded";
		--["Content-Length"] = #request_body;
	};
	source = ltn12.source.string(request_body);
	sink = ltn12.sink.table(response_body);
}

print("Status:", res and "OK" or "FAILED")
print("HTTP code:", code)

print("#==== Response headers ====#")
if type(response_headers) == "table" then
	for k, v in pairs(response_headers) do
		print(k, ":", v)
	end
else
	-- Would be nil, if there is an error
	print("Not a table:", type(response_headers))
end

print("#==== Response body ====#")
if type(response_body) == "table" then
	print(table.concat(response_body))
else
	-- Would be nil, if there is an error
	print("Not a table:", type(response_body))
end

print("#==== Done dumping response ====#")
