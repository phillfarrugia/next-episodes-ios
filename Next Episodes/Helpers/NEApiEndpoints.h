//
//  NEApiEndpoints.h
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEApiEndpoints : NSObject

- (NSURLRequest *)trendingShowsRequest;

- (NSURLRequest *)latestEpisodeForShowId:(NSNumber *)showId;

- (NSURLRequest *)searchShowsByQueryString:(NSString *)queryString;

+ (instancetype)endpoints;

@end
