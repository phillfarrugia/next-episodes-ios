//
//  NEDataManager.m
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEApiCommunicator.h"
#import "NEDataManager.h"

@interface NEDataManager ()

@property NEApiCommunicator *dataSource;

@end

@implementation NEDataManager

+ (instancetype)dataManagerWithDataSource:(NEApiCommunicator *)dataSource
{
    return [[NEDataManager alloc] initWithDataSource:dataSource];
}

- (instancetype)initWithDataSource:(NEApiCommunicator *)dataSource
{
    self = [super init];
    
    if (self) {
        self.dataSource = dataSource;
    }
    
    return self;
}

- (void)collectionOfType:(Class)dataModelType
          fromURLRequest:(NSURLRequest *)urlRequest
                 success:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, NSArray *collection))success
                 failure:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, NSError *error))failure
{
    [self.dataSource dataFromURLRequest:urlRequest success:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSDictionary *response) {
        success(self, dataModelType, urlRequest, [MTLJSONAdapter modelOfClass:dataModelType fromJSONDictionary:response error:nil]);
    } failure:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSError *error) {
        failure(self, dataModelType, urlRequest, error);
    }];
}

- (void)entityOfType:(Class)dataModelType
      fromURLRequest:(NSURLRequest *)urlRequest
             success:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, Class entity))success
             failure:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, NSError *error))failure
{
    [self.dataSource dataFromURLRequest:urlRequest success:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSDictionary *response) {
        success(self, dataModelType, urlRequest, [MTLJSONAdapter modelOfClass:dataModelType fromJSONDictionary:response error:nil]);
    } failure:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSError *error) {
        failure(self, dataModelType, urlRequest, error);
    }];
}

@end
