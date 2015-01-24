//
//  NEEpisodeModel.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEEpisodeModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface NEEpisodeModel ()

@property (getter=isWatched) BOOL watched;

@end

@implementation NEEpisodeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"traktId": @"ids.trakt",
             @"airdate": @"first_aired",
             @"episode": @"number"
             };
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

- (instancetype)copyWithWatched:(BOOL)watched
{
    NEEpisodeModel *copy = [self copy];
    copy.watched = watched;
    
    return copy;
}

@end

@implementation NEEpisodeModelDecoder

#pragma mark JsonDataModelDecoder

+ (NSArray *)decodeCollection:(NSDictionary *)collectionDict error:(NSError **)error
{
    NSArray *collection = (NSArray *)collectionDict[@"episodes"];
    
    if (error && *error) {
        return nil;
    }
    
    return [MTLJSONAdapter modelsOfClass:[NEEpisodeModel class] fromJSONArray:collection error:error];
}

+ (NSDictionary *)encodeCollection:(NSArray *)collection
{
    return @{@"episodes": [MTLJSONAdapter JSONArrayFromModels:collection]};
}

+ (MTLModel *)decodeEntity:(NSDictionary *)entityDict error:(NSError **)error
{
    return [MTLJSONAdapter modelOfClass:[NEEpisodeModel class] fromJSONDictionary:entityDict error:error];
}

@end