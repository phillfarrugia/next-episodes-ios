//
//  NEShow.m
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEShowModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation NEShowModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"traktId": @"ids.trakt",
             @"airdate": @"airs",
             @"poster": @"images.poster.medium"
             };
}

+ (NSValueTransformer *)posterJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)statusJSONTransformer
{
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
            @"returning series": @(NEShowStatusReturning),
            @"in production": @(NEShowStatusInProduction),
            @"ended": @(NEShowStatusEnded),
            @"canceled": @(NEShowStatusCanceled)
            }];
}

+ (NSValueTransformer *)airdateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *string) {
        if (string) {
            NSTimeInterval timeInterval = [string doubleValue];
            
            return [NSDate dateWithTimeIntervalSince1970:timeInterval];
        } else {
            return nil;
        }
    } reverseBlock:^(NSDate *date) {
        NSTimeInterval timeInterval = [date timeIntervalSince1970];
        
        return [NSString stringWithFormat:@"%f", timeInterval];
    }];
}

@end

@implementation NEShowModelDecoder

#pragma mark JsonDataModelDecoder

+ (NSArray *)decodeCollection:(NSDictionary *)collectionDict error:(NSError **)error
{
    NSArray *collection = (NSArray *)collectionDict[@"shows"];
    
    if (error && *error) {
        return nil;
    }
    
    return [MTLJSONAdapter modelsOfClass:[NEShowModel class] fromJSONArray:collection error:error];
}

+ (NSDictionary *)encodeCollection:(NSArray *)collection
{
    return @{@"shows": [MTLJSONAdapter JSONArrayFromModels:collection]};
}

+ (MTLModel *)decodeEntity:(NSDictionary *)entityDict error:(NSError **)error
{
    return [MTLJSONAdapter modelOfClass:[NEShowModel class] fromJSONDictionary:entityDict error:error];
}

@end
