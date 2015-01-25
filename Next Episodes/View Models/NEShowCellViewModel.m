//
//  NEShowCellViewModel.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEShowCellViewModel.h"
#import "NEShowModel.h"
#import "NSDate+DateTools.h"

static const CGFloat NEShowCellViewModelHeight = 85;

@interface NEShowCellViewModel ()

@property (nonatomic) NEShowModel *show;

@end

@implementation NEShowCellViewModel

#pragma mark - View Model Lifecycle

- (instancetype)initWithShow:(NEShowModel *)show
{
    if ((self = [super init])) {
        self.show = show;
    }
    
    return self;
}

- (NSString *)title
{
    return self.show.title;
}

- (NSString *)overview
{
    return self.show.overview;
}

- (NSString *)airdate
{
    return [self.show.airdate formattedDateWithFormat:@"EEEE hh:mm a" timeZone:[NSTimeZone localTimeZone]];
}

- (NSString *)runtime
{
    return [NSString stringWithFormat:@"%@ mins", [self.show.runtime stringValue]];
}

- (NSString *)status
{
    switch (self.show.status) {
        case NEShowStatusInProduction:
            return @"In Production";
        case NEShowStatusReturning:
            return @"Returning Series";
        case NEShowStatusEnded:
            return @"Ended";
        case NEShowStatusCanceled:
            return @"Cancelled";
        case NEShowStatusUnknown:
            return nil;
    }
}

- (NSURL *)poster
{
    return self.show.poster;
}

- (CGFloat)cellHeight
{
    return NEShowCellViewModelHeight;
}

@end
