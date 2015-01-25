//
//  NEShowDetailViewController.m
//  Next Episodes
//
//  Created by Phill Farrugia on 25/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEShowDetailViewController.h"
#import "NEShowModel.h"

@interface NEShowDetailViewController ()

@property (nonatomic) NEShowModel *show;

@end

@implementation NEShowDetailViewController

- (instancetype)initWithShow:(NEShowModel *)show
{
    self = [super init];
    
    if (self) {
        _show = show;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [self.show title];
    [self prepareViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareViews
{
}

@end
