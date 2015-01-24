//
//  NEShowTableViewCell2.h
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NEShowCellViewModel;

@interface NEShowTableViewCell : UITableViewCell

- (void)setViewModel:(NEShowCellViewModel *)viewModel;

@end
