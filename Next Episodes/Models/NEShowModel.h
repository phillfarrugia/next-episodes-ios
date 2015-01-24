//
//  NEShow.h
//  Next Episodes
//
//  Created by Phill Farrugia on 21/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "NEJsonDataModelDecoder.h"

typedef enum : NSUInteger {
    NEShowStatusReturning,
    NEShowStatusInProduction,
    NEShowStatusEnded,
    NEShowStatusCanceled
} NEShowStatus;

@interface NEShowModel : MTLModel <MTLJSONSerializing>

@property (readonly) NSNumber *traktId;

@property (readonly) NSString *title;
@property (readonly) NSString *overview;
@property (readonly) NSNumber *year;

@property (readonly) NSURL *poster;

@property (readonly) NSDate *airdate;
@property (readonly) NSNumber *runtime;

@property (readonly) NSString *certification;
@property (readonly) NSString *network;

@property (nonatomic, assign, readonly) NEShowStatus status;

@end

@interface NEShowModelDecoder : NSObject <NEJsonDataModelDecoder>

@end
