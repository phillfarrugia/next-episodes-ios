//
//  NEShow.m
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEShow.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

typedef enum : NSUInteger {
    NEShowStatusReturning,
    NEShowStatusInProduction,
    NEShowStatusEnded
} NEShowStatus;

@interface NEShow ()

@property (nonatomic, readonly) NSNumber *traktId;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *overview;
@property (nonatomic, readonly) NSNumber *year;

@property (nonatomic, readonly) NSURL *poster;

@property (nonatomic, readonly) NSDate *airDate;
@property (nonatomic, readonly) NSNumber *runtime;
@property (nonatomic, readonly) NSString *certification;
@property (nonatomic, readonly) NSString *network;

@property (nonatomic, assign, readonly) NEShowStatus *status;

@end

@implementation NEShow

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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string) {
        return [formatter dateFromString:string];
    } reverseBlock:^(NSDate *date) {
        return [formatter stringFromDate:date];
    }];
}

@end
