//
//  NEAPICommunicator.h
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

@interface NEApiCommunicator : NSObject

+ (instancetype)apiCommunicator;

- (NSOperation *)dataFromURLRequest:(NSURLRequest *)urlRequest
                            success:(void (^)(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSDictionary *response))success
                            failure:(void (^)(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSError *error))failure;

@end
