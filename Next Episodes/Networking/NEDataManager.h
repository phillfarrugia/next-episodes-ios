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

- (void)collectionOfType:(Class)dataModelType
          fromURLRequest:(NSURLRequest *)urlRequest
                 success:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, NSArray *collection))success
                 failure:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, NSError *error))failure;

- (void)entityOfType:(Class)dataModelType
      fromURLRequest:(NSURLRequest *)urlRequest
             success:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, Class entity))success
             failure:(void (^)(NEDataManager *dataManager, Class dataModelType, NSURLRequest *urlRequest, NSError *error))failure;

@end
