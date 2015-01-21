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
                            success:(void (^)(NSURLRequest *, NSDictionary *))success
                            failure:(void (^)(NSURLRequest *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:urlRequest
                                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                  success(urlRequest, (NSDictionary *)responseObject);
                                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                  failure(urlRequest, error);
                                                              }];
    [manager.operationQueue addOperation:operation];
    
    return operation;
}

@end

#pragma mark - DataManagerDataSource