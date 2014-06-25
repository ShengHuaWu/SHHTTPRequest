# SHHTTPRequest
This project is used to send HTTP requests synchronously or asynchronously.
It contains a primary class _SHNetworking_.

## SHNetworking
Send http request synchronously or asynchronously.

* Please read more details in the .h file.

Synchronous methods:

		- (NSData *)httpGetRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters response:(NSHTTPURLResponse **)response andError:(NSError **)error;

		- (NSData *)httpPostRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData response:(NSHTTPURLResponse **)response andError:(NSError **)error;

		- (NSData *)httpPutRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData response:(NSHTTPURLResponse **)response andError:(NSError **)error;

		- (NSData *)httpDeleteRequestWithURL:(NSURL *)url headers:(NSDictionary *)headers response:(NSHTTPURLResponse **)response andError:(NSError **)error;

Asynchronous methods:

		- (void)httpGetRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters andCompletion:(SHNetworkingCompletion)completion;

		- (void)httpPostRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData andCompletion:(SHNetworkingCompletion)completion;

		- (void)httpPutRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers jsonData:(NSData *)jsonData andCompletion:(SHNetworkingCompletion)completion;

		- (void)httpDeleteRequestInBackgroundWithURL:(NSURL *)url headers:(NSDictionary *)headers andCompletion:(SHNetworkingCompletion)completion;
