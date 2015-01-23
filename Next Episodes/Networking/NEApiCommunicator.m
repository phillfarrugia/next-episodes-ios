//
//  NEAPICommunicator.m
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEApiCommunicator.h"
#import <AFNetworking/AFNetworking.h>

@implementation NEApiCommunicator

+ (instancetype)apiCommunicator
{
    return [[self alloc] init];
}

- (NSOperation *)dataFromURLRequest:(NSURLRequest *)urlRequest
                            success:(void (^)(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSDictionary *response))success
                            failure:(void (^)(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:urlRequest
                                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                  success(self, urlRequest, (NSDictionary *)responseObject);
                                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                  failure(self, urlRequest, error);
                                                              }];
    [manager.operationQueue addOperation:operation];
    
    return operation;
}

@end