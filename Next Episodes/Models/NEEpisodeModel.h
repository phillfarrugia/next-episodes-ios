//
//  NEEpisodeModel.h
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "NEJsonDataModelDecoder.h"

@interface NEEpisodeModel : MTLModel <MTLJSONSerializing>

@property (readonly) NSNumber *traktId;

@property (readonly) NSString *title;
@property (readonly) NSString *overview;

@property (readonly) NSNumber *season;
@property (readonly) NSNumber *episode;

@property (readonly) NSDate *airDate;

@property (readonly, getter=isWatched) BOOL watched;

- (instancetype)copyWithWatched:(BOOL)watched;

@end

@interface NEEpisodeModelDecoder : NSObject <NEJsonDataModelDecoder>

@end

