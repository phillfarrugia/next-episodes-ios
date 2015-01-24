//
//  UIColor+NextEpisodes.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "UIColor+NextEpisodes.h"

@implementation UIColor (NextEpisodes)

+ (UIColor *)navigationColor
{
    return [UIColor colorWithRed:204 / 255.0f green:110 / 255.0f blue:131 / 255.0f alpha:1.0f];
}

/*
 Segmented Control
 */
+ (UIColor *)segmentBackgroundColor
{
    return [UIColor colorWithRed:235 / 255.0f green:235 / 255.0f blue:235 / 255.0f alpha:1.0f];
}

+ (UIColor *)selectedSegmentBackgroundColor
{
    return [UIColor colorWithRed:255 / 255.0f green:255 / 255.0f blue:255 / 255.0f alpha:1.0f];
}

+ (UIColor *)segmentBorderColor
{
    return [UIColor colorWithRed:173 / 255.0f green:173 / 255.0f blue:173 / 255.0f alpha:1.0f];
}

+ (UIColor *)segmentTitleColor
{
    return [UIColor colorWithRed:198 / 255.0f green:198 / 255.0f blue:198 / 255.0f alpha:1.0f];
}

+ (UIColor *)selectedSegmentTitleColor
{
    return [UIColor colorWithRed:74 / 255.0f green:74 / 255.0f blue:74 / 255.0f alpha:1.0f];
}

@end
