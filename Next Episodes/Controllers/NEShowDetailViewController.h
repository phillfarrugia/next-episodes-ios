//
//  NEShowDetailViewController.h
//  Next Episodes
//
//  Created by Phill Farrugia on 25/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEShowModel;

@interface NEShowDetailViewController : UIViewController

- (instancetype)initWithShow:(NEShowModel *)show;

@end
