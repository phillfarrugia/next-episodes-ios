//
//  NEShowsDataManager.h
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@class NEEpisodeModel;
@class NEListModel;
@class NEShowModel;

@interface NEListDataManager : NSObject

@property (readonly, nonatomic) NEListModel *list;

@property (readonly, nonatomic) RACSubject *listDidChangeSubject;

#pragma mark - Methods
+ (instancetype)defaultManager;

- (BOOL)clearList;

- (BOOL)listContainsShowWithTraktId:(NSNumber *)traktId;

- (NEListModel *)addShow:(NEShowModel *)show;

- (NEListModel *)removeShow:(NEShowModel *)show;

- (NEListModel *)replaceShow:(NEShowModel *)oldShow withNewShow:(NEShowModel *)newShow;

- (NEListModel *)addEpisode:(NEEpisodeModel *)episode;

- (NEListModel *)removeEpisode:(NEEpisodeModel *)episode;

- (NEListModel *)updateEpisode:(NEEpisodeModel *)episode withIsWatched:(BOOL)watched;

@end

#pragma mark - ListDidChange Tuple

typedef NS_ENUM(NSUInteger, NEListChangeType)
{
    NEListChangeTypeAdded,
    NEListChangeTypeRemoved,
    NEListChangeTypeReplaced,
};

/**
 *  If itemChanged is nil, then the listItself was added or removed
 *  otherwise, the itemChanged, from the listChanged, has been WOWListItemChangeReplaced, WOWListItemChangeRemoved or WOWListItemChangeAdded
 */
@interface NEListChangeTuple : NSObject

@property (readonly) id itemChanged;
@property (readonly) NEListModel *listChanged;
@property (readonly) NEListChangeType changeType;

+ (NEListChangeTuple *)tupleWithItemChanged:(id)itemChanged
                                 listChanged:(NEListModel *)listModel
                                 changeType:(NEListChangeType)changeType;

@end
