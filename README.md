## SHHTTPRequest
This project is used to send HTTP requests synchronously or asynchronously. It contains a main class _SHNetworking_ and some categorys. The _MainViewController_ contains some test methods.

### Usage
1. Create the HTTPRequestInfo in your plist. It should contain AppID, AppKey, Host, Port.

2. Set the HTTPRequestInfoKey in the top of SHNetworking.h to the Name of your HTTPRequestInfo, such as @"HTTPRequestInfo".

3. You are available to use the HTTP GET, POST, PUT and DELETE requests.

### Class
#### SHNetworking
This class is used to send http request synchronously or asynchronously.

* Please read more details in the .h file.

Synchronous methods:

		+ (id)httpGetRequestWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters andError:(NSError **)error;

		+ (id)httpPostRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError **)error;

		+ (id)httpPutRequestWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json andError:(NSError **)error;

		+ (id)httpDeleteRequestWithPath:(NSString *)path header:(NSDictionary *)header andError:(NSError **)error;

Asynchronous methods:

		+ (void)httpGetRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header parameters:(NSDictionary *)parameters completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

		+ (void)httpPostRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

		+ (void)httpPutRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header json:(id)json completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;

		+ (void)httpDeleteRequestInBackgroundWithPath:(NSString *)path header:(NSDictionary *)header completionBlock:(SHNetWorkingCompletionBlock)completionBlock andFailureBlock:(SHNetWorkingFailureBlock)failureBlock;