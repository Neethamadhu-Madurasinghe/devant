import ballerina/http;

// HTTP client for imgflip API
final http:Client imgflipClient = check new ("https://api.imgflip.com");

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /helloworld on httpDefaultListener {
    resource function get greeting() returns error|json|http:InternalServerError {
        do {
            return "Hello World";
        } on fail error err {
            return error("unhandled error", err);
        }
    }

    resource function get get_meme() returns error|json {
        do {
            json response = check imgflipClient->/get_memes.get();
            return response;
        } on fail error err {
            return error("Failed to fetch memes", err);
        }
    }
}
