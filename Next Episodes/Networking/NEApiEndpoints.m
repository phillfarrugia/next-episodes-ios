//
//  NEApiEndpoints.m
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEApiEndpoints.h"
#import "AFURLRequestSerialization.h"

static NSString * const NEApiTrendingShowsEndpoint = @"https://next-episodes-api.herokuapp.com/api/v1/trending";
static NSString * const NEApiLatestEpisodeEndpoint = @"https://next-episodes-api.herokuapp.com/api/v1/latest/";
static NSString * const NEApiShowSearchEndpoint = @"https://next-episodes-api.herokuapp.com/api/v1/search/";

@interface NEApiEndpoints ()

@property (nonatomic) AFHTTPRequestSerializer *requestSerializer;

@end

@implementation NEApiEndpoints

+ (instancetype)endpoints
{
    static NEApiEndpoints * apiEndpoints = nil;
    
    if (!apiEndpoints) {
        apiEndpoints = [[NEApiEndpoints alloc] init];
    }
    
    return apiEndpoints;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    return self;
}

- (NSURLRequest *)trendingShowsRequest
{
    return [self urlRequestWithHTTPVerb:@"GET" url:NEApiTrendingShowsEndpoint params:nil];
}

- (NSURLRequest *)latestEpisodeForShowId:(NSNumber *)showId
{
    NSDictionary *params = @{ @"id": [showId stringValue] };
    return [self urlRequestWithHTTPVerb:@"GET" url:NEApiLatestEpisodeEndpoint params:params];
}

- (NSURLRequest *)searchShowsByQueryString:(NSString *)queryString
{
    NSString *urlEncoded = [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *params = @{ @"query": urlEncoded };
    return [self urlRequestWithHTTPVerb:@"GET" url:NEApiShowSearchEndpoint params:params];
}

- (NSURLRequest *)urlRequestWithHTTPVerb:(NSString *)verb url:(NSString *)url params:(NSDictionary *)params
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:verb URLString:url parameters:params error:nil];
    
    return request;
}

@end
