//
//  NEShowsDataManager.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NEListDataManager.h"
#import "NEListModel.h"
#import "NEShowModel.h"
#import "NEEpisodeModel.h"

static NSString * const fullListName = @"ListCollection.json";

@interface NEListDataManager ()

@property (nonatomic)  NSURL *docPathURL;
@property NEListModel *list;
@property (nonatomic, strong) dispatch_queue_t archiveQueue;

@property (nonatomic) RACSubject *listItemDidChangeSubject;

@end

@implementation NEListDataManager

#pragma mark - Lifecycle

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    static NEListDataManager * defaultManager;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    
    return defaultManager;
}

- (instancetype)init
{
    if ((self = [super init])) {
        self.archiveQueue = dispatch_queue_create("com.nextepisodes.archivequeue",  DISPATCH_QUEUE_SERIAL);
        [self createRACSignals];
    }
    
    return self;
}

#pragma mark - Create Signals

- (void)createRACSignals
{
    self.listItemDidChangeSubject = [RACSubject subject];
}

#pragma mark - Accessors

- (NEListModel *)list
{
    @synchronized(self) {
        if (self.list == nil) {
            NSString *filename = [[[self docPathURL] path] stringByAppendingPathComponent:fullListName];
            NSData *listData = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
            
            if (listData == nil) {
                self.list = [[NEListModel alloc] initWithStandardValues];
            } else {
                NEListModel *listModel = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedUnarchiver unarchiveObjectWithFile:filename]];
                self.list = listModel;
            }
        }
        
        return _list;
    }
}

- (BOOL)clearList
{
    self.list = [[NEListModel alloc] initWithStandardValues];
    
    return YES;
}

- (BOOL)listContainsShowWithTraktId:(NSNumber *)traktId
{
    for (NEShowModel *show in [self.list shows]) {
        if ([show.traktId isEqualToNumber:traktId]) {
            return YES;
        }
    }
    
    return NO;
}

- (NEListModel *)addShow:(NEShowModel *)show
{
    self.list = [_list addShow:show];
    
    return self.list;
}

- (NEListModel *)removeShow:(NEShowModel *)show
{
    self.list = [_list removeShow:show];
    
    return self.list;
}

- (NEListModel *)replaceShow:(NEShowModel *)oldShow withNewShow:(NEShowModel *)newShow
{
    self.list = [_list replaceShow:oldShow withShow:newShow];
    
    return self.list;
}

- (NEListModel *)addEpisode:(NEEpisodeModel *)episode
{
    self.list = [_list addEpisode:episode];
    
    return self.list;
}

- (NEListModel *)removeEpisode:(NEEpisodeModel *)episode
{
    self.list = [_list removeEpisode:episode];
    
    return self.list;
}

- (NEListModel *)updateEpisode:(NEEpisodeModel *)episode withIsWatched:(BOOL)watched
{
    NEEpisodeModel *newEpisode = [episode copyWithWatched:YES];
    self.list = [_list replaceEpisode:episode withEpisode:newEpisode];
    
    return self.list;
}

@end
