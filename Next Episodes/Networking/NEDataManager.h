//
//  NEDataManager.h
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Mantle/MTLJSONAdapter.h>
#import "NEApiCommunicator.h"
#import "NEDataModelTypes.h"

@interface NEDataManager : NSObject

+ (instancetype)dataManagerWithDataSource:(NEApiCommunicator *)dataSource;

- (void)collectionOfType:(NEDataModelType)dataModelType
          fromURLRequest:(NSURLRequest *)urlRequest
                 success:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSArray *collection))success
                 failure:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSError *error))failure;

- (void)entityOfType:(NEDataModelType)dataModelType
      fromURLRequest:(NSURLRequest *)urlRequest
             success:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, MTLModel *entity))success
             failure:(void (^)(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSError *error))failure;

- (NSDictionary *)encodeCollection:(NSArray *)collection
                            ofType:(NEDataModelType)dataModelType;
- (NSDictionary *)encodeEntity:(MTLModel <MTLJSONSerializing> *)entity
                        ofType:(NEDataModelType)dataModelType;

- (NSArray *)decodeCollection:(NSDictionary *)collectionDict
                       ofType:(NEDataModelType)dataModelType
                        error:(NSError **)error;
- (MTLModel *)decodeEntity:(NSDictionary *)entityDict
                    ofType:(NEDataModelType)dataModelType
                     error:(NSError **)error;

@end
