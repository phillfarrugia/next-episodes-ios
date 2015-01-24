//
//  ViewController.m
//  Next Episodes
//
//  Created by Phill Farrugia on 19/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEMainViewController.h"
#import "NYSegmentedControl.h"

@interface NEMainViewController ()

@property (nonatomic) NYSegmentedControl *segmentedControl;

@end

@implementation NEMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSegmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSegmentedControl
{
    NYSegmentedControl *segmentedControl = [[NYSegmentedControl alloc] initWithItems:@[ @"Shows", @"Episodes" ]];
    [segmentedControl addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.backgroundColor = [UIColor segmentBackgroundColor];
    segmentedControl.segmentIndicatorBackgroundColor = [UIColor selectedSegmentBackgroundColor];
    segmentedControl.borderColor = [UIColor segmentBorderColor];
    segmentedControl.titleTextColor = [UIColor segmentTitleColor];
    segmentedControl.selectedTitleTextColor = [UIColor selectedSegmentTitleColor];
    segmentedControl.drawsGradientBackground = NO;
    
    segmentedControl.titleFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    segmentedControl.selectedTitleFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    segmentedControl.cornerRadius = 10.0f;
    [segmentedControl sizeToFit];
    
    self.segmentedControl = segmentedControl;
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)segmentSelected
{
    NSUInteger index = self.segmentedControl.selectedSegmentIndex;
    NSLog(@"%lu", (unsigned long)index);
}

@end
