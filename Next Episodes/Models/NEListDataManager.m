//
//  NEShowsDataManager.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEListDataManager.h"
#import "NEListModel.h"
#import "NEShowModel.h"
#import "NEEpisodeModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const fullListName = @"ListCollection.json";

@interface NEListDataManager ()

@property (nonatomic)  NSURL *docPathURL;
@property NEListModel *list;
@property (nonatomic, strong) dispatch_queue_t archiveQueue;

@property (nonatomic) RACSubject *listDidChangeSubject;

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
        self.listDidChangeSubject = [RACSubject subject];
    }
    
    return self;
}

#pragma mark - Accessors

- (NEListModel *)list
{
        if (_list == nil) {
            NSString *filename = [[[self docPathURL] path] stringByAppendingPathComponent:fullListName];
            NSData *listData = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
            
            if (listData == nil) {
                _list = [[NEListModel alloc] initWithStandardValues];
            } else {
                NEListModel *listModel = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedUnarchiver unarchiveObjectWithFile:filename]];
                _list = listModel;
            }
        }
        
        return _list;
}

- (BOOL)clearList
{
    _list = [[NEListModel alloc] initWithStandardValues];
    [self saveList];

    [self.listDidChangeSubject sendNext:@(YES)];
    
    return YES;
}

- (BOOL)listContainsShowWithTraktId:(NSNumber *)traktId
{
    for (NEShowModel *show in [_list shows]) {
        if ([show.traktId isEqualToNumber:traktId]) {
            return YES;
        }
    }
    
    return NO;
}

- (NEListModel *)addShow:(NEShowModel *)show
{
    _list = [_list addShow:show];
    [self saveList];
    
    [self.listDidChangeSubject sendNext:[NEListChangeTuple tupleWithItemChanged:show
                                                                    listChanged:_list
                                                                     changeType:NEListChangeTypeAdded]];
    
    return _list;
}

- (NEListModel *)removeShow:(NEShowModel *)show
{
    _list = [_list removeShow:show];
    [self saveList];
    
    [self.listDidChangeSubject sendNext:[NEListChangeTuple tupleWithItemChanged:show
                                                                    listChanged:_list
                                                                     changeType:NEListChangeTypeRemoved]];
    
    return _list;
}

- (NEListModel *)replaceShow:(NEShowModel *)oldShow withNewShow:(NEShowModel *)newShow
{
    _list = [_list replaceShow:oldShow withShow:newShow];
    [self saveList];
    
    [self.listDidChangeSubject sendNext:[NEListChangeTuple tupleWithItemChanged:oldShow
                                                                    listChanged:_list
                                                                     changeType:NEListChangeTypeReplaced]];
    
    return _list;
}

- (NEListModel *)addEpisode:(NEEpisodeModel *)episode
{
    _list = [_list addEpisode:episode];
    [self saveList];
    
    [self.listDidChangeSubject sendNext:[NEListChangeTuple tupleWithItemChanged:episode
                                                                    listChanged:_list
                                                                     changeType:NEListChangeTypeAdded]];
    
    return _list;
}

- (NEListModel *)removeEpisode:(NEEpisodeModel *)episode
{
    _list = [_list removeEpisode:episode];
    [self saveList];
    
    [self.listDidChangeSubject sendNext:[NEListChangeTuple tupleWithItemChanged:episode
                                                                    listChanged:_list
                                                                     changeType:NEListChangeTypeRemoved]];
    
    return _list;
}

- (NEListModel *)updateEpisode:(NEEpisodeModel *)episode withIsWatched:(BOOL)watched
{
    NEEpisodeModel *newEpisode = [episode copyWithWatched:YES];
    _list = [_list replaceEpisode:episode withEpisode:newEpisode];
    [self saveList];
    
    [self.listDidChangeSubject sendNext:[NEListChangeTuple tupleWithItemChanged:episode
                                                                    listChanged:_list
                                                                     changeType:NEListChangeTypeReplaced]];
    
    return _list;
}

- (void)saveList
{
    dispatch_async(self.archiveQueue, ^{
        NSString *filename = [[[self docPathURL] path] stringByAppendingPathComponent:fullListName];
        NSData *jsonData = [NSKeyedArchiver archivedDataWithRootObject:_list];
        [NSKeyedArchiver archiveRootObject:jsonData toFile:filename];
    });
}

- (NSURL *)docPathURL
{
    if (_docPathURL == nil) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSURL *dir = [fileManager URLForDirectory:NSDocumentDirectory
                                         inDomain:NSUserDomainMask
                                appropriateForURL:nil
                                           create:YES
                                            error:nil];
        _docPathURL = [[NSURL alloc] initFileURLWithPath:[dir path] isDirectory:YES];
        
        if (![fileManager fileExistsAtPath:[_docPathURL path]]) {
            [[NSFileManager defaultManager] createDirectoryAtURL:_docPathURL withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return _docPathURL;
}

@end

#pragma mark - Tuple

@interface NEListChangeTuple ()

@property (readwrite) id itemChanged;
@property (readwrite) NEListModel *listChanged;
@property (readwrite) NEListChangeType changeType;

@end

@implementation NEListChangeTuple

+ (NEListChangeTuple *)tupleWithItemChanged:(id)itemChanged
                                 listChanged:(NEListModel *)listModel
                                 changeType:(NEListChangeType)changeType;
{
    NEListChangeTuple *tuple = [[NEListChangeTuple alloc] init];
    
    tuple.itemChanged = itemChanged;
    tuple.listChanged = listModel;
    tuple.changeType  = changeType;
    
    return tuple;
}

@end
