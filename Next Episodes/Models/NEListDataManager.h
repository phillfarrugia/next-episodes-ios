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

#pragma mark - Signals For State Change
@property (readonly, nonatomic) RACSubject *listItemDidChangeSubject;

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
