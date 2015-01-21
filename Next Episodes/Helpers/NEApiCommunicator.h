//
//  NEAPICommunicator.h
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEApiCommunicator : NSObject

+ (instancetype)apiCommunicator;

- (NSOperation *)dataFromURLRequest:(NSURLRequest *)urlRequest
                            success:(void (^)(NSURLRequest *urlRequest, NSDictionary *response))success
                            failure:(void (^)(NSURLRequest *urlRequest, NSError *error))failure;

@end
