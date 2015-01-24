//
//  NEShowCellViewModel.h
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

@class NEShowModel;

@interface NEShowCellViewModel : NSObject

@property (readonly) NSString *title;
@property (readonly) NSString *overview;

@property (readonly) NSString *airdate;
@property (readonly) NSString *runtime;
@property (readonly) NSString *status;

@property (readonly) NSURL *poster;

@property (readonly, nonatomic) CGFloat cellHeight;

- (instancetype)initWithShow:(NEShowModel *)show;

@end
