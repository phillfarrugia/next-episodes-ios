//
//  NEDataModelDecoder.h
//  Next Episodes
//
//  Created by Phill Farrugia on 22/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTLModel;

@protocol NEJsonDataModelDecoder

/**
 Translate a dictionary containing an array of JSON object representations into `MTLModel`s.
 */
+ (NSArray *)decodeCollection:(NSDictionary *)collectionDict error:(NSError **)error;

/**
 Translate an array of `MTLModels` into a dictionary containing an array of JSON object representations.
 */
+ (NSDictionary *)encodeCollection:(NSArray *)collection;

/**
 Translate a dictionary containing a JSON object representation into an `MTLModel`.
 */
+ (MTLModel *)decodeEntity:(NSDictionary *)entityDict error:(NSError **)error;

@end