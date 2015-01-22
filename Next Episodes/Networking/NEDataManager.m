//
//  NEDataManager.m
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEApiCommunicator.h"
#import "NEDataManager.h"
#import "NEDataModelTypes.h"

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

- (void)collectionOfType:(NEDataModelType)dataModelType
          fromURLRequest:(NSURLRequest *)urlRequest
                 success:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSArray *collection))success
                 failure:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSError *error))failure
{
    [self.dataSource dataFromURLRequest:urlRequest success:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSDictionary *response) {
        NSError *error;
        NSArray *collection = [self decodeCollection:response ofType:dataModelType error:&error];
        
        if (collection && !error) {
            if (success) {
                success(self, dataModelType, urlRequest, collection);
            }
        } else {
            if (failure) {
                failure(self, dataModelType, urlRequest, error);
            }
        }
        
    } failure:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSError *error) {
        failure(self, dataModelType, urlRequest, error);
    }];
}

- (void)entityOfType:(NEDataModelType)dataModelType
      fromURLRequest:(NSURLRequest *)urlRequest
             success:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, MTLModel *entity))success
             failure:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSError *error))failure
{
    [self.dataSource dataFromURLRequest:urlRequest success:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSDictionary *response) {
        NSError *error;
        MTLModel *entity = [self decodeEntity:response ofType:dataModelType error:&error];
        
        if (entity && !error) {
            if (success) {
                success(self, dataModelType, urlRequest, entity);
            }
        } else {
            if (failure) {
                failure(self, dataModelType, urlRequest, error);
            }
        }
        
    } failure:^(NEApiCommunicator *dataSource, NSURLRequest *urlRequest, NSError *error) {
        failure(self, dataModelType, urlRequest, error);
    }];
}

- (NSDictionary *)encodeCollection:(NSArray *)collection ofType:(NEDataModelType)dataModelType
{
    return [dataModelDecoderOfType(dataModelType) encodeCollection:collection];
}

- (NSDictionary *)encodeEntity:(MTLModel <MTLJSONSerializing> *)entity ofType:(NEDataModelType)dataModelType
{
    return [MTLJSONAdapter JSONDictionaryFromModel:entity];
}

- (NSArray *)decodeCollection:(NSDictionary *)collectionDict ofType:(NEDataModelType)dataModelType error:(NSError **)error
{
    return [dataModelDecoderOfType(dataModelType) decodeCollection:collectionDict error:error];
}

- (MTLModel *)decodeEntity:(NSDictionary *)entityDict ofType:(NEDataModelType)dataModelType error:(NSError **)error
{
    return [dataModelDecoderOfType(dataModelType) decodeEntity:entityDict error:error];
}

@end
