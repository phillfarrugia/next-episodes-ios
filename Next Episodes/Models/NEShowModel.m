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
             @"airDate": @"air_date",
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
            @"canceled": @(NEShowStatusEnded)
            }];
}

+ (NSValueTransformer *)airDateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *string) {
        if (string) {
            return [self.dateFormatter dateFromString:string];
        } else {
            return nil;
        }
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter * _formatter;
    
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [_formatter setLocale:posix];
    }
    
    return _formatter;
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
