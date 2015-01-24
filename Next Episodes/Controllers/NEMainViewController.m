//
//  ViewController.m
//  Next Episodes
//
//  Created by Phill Farrugia on 19/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEMainViewController.h"
#import "NYSegmentedControl.h"
#import "NEListDataManager.h"
#import "NEListModel.h"

@interface NEMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NYSegmentedControl *segmentedControl;
@property (nonatomic) UITableView *tableView;

@property (nonatomic) NEListModel *list;

@end

@implementation NEMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.list = [[NEListDataManager defaultManager] list];
    [self prepareViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareViews
{
    [self prepareTableView];
    [self setupSegmentedControl];
    
    UIBarButtonItem *addShowButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add Show Icon"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didSelectAddShow)];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Settings Icon"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didSelectSettings)];
    
    [addShowButton setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = addShowButton;
    [settingsButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = settingsButton;
}

#pragma mark Segmented Control

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

- (void)prepareTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list.shows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"show.cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"show.cell"];
    }
    
    return cell;
}

#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didSelectAddShow
{
    NSLog(@"Add show");
}

- (void)didSelectSettings
{
    NSLog(@"Settings");
}

@end
