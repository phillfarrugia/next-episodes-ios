//
//  NEAddShowViewController.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEAddShowViewController.h"
#import "NEListDataManager.h"
#import "NEDataManager.h"
#import "NEApiEndpoints.h"
#import "NEShowModel.h"
#import "NSDate+DateTools.h"
#import "NEShowTableViewCell.h"
#import "NEShowCellViewModel.h"

@interface NEAddShowViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *shows;

@end

@implementation NEAddShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareTableView];
    [self prepareViews];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NEShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"NEShowCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTrendingShows
{
    NSURLRequest *trendingShowsRequest = [[NEApiEndpoints endpoints] trendingShowsRequest];
    [[NEDataManager dataManagerWithDataSource:[NEApiCommunicator apiCommunicator]] collectionOfType:NEDataModelTypeShow fromURLRequest:trendingShowsRequest success:^(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSArray *collection) {
        self.shows = collection;
        [self.tableView reloadData];
    } failure:^(NEDataManager *dataManager, NEDataModelType dataModelType, NSURLRequest *urlRequest, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Uh oh! Could not fetch data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)prepareViews
{
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Close Icon"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(didSelectDismiss)];
    
    [dismissButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = dismissButton;
}

- (void)prepareTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self fetchTrendingShows];
}

#pragma mark Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NEShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NEShowCell"];
    
    NEShowCellViewModel *viewModel = [[NEShowCellViewModel alloc] initWithShow:self.shows[indexPath.row]];
    [cell setViewModel:viewModel];
    
    return cell;
}

#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NEShowModel *show = [self.shows objectAtIndex:indexPath.row];
    [[NEListDataManager defaultManager] addShow:show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100; //TODO: This should not be hardcoded
}

- (void)didSelectDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
