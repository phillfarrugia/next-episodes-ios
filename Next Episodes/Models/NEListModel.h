//
//  NEListModel.h
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "MTLModel.h"
@class NEShowModel;
@class NEEpisodeModel;

@interface NEListModel : MTLModel

@property (readonly, nonatomic) NSArray *shows;
@property (readonly, nonatomic) NSArray *episodes;

- (instancetype)initWithStandardValues;

- (NEListModel *)addShow:(NEShowModel *)show;

- (NEListModel *)removeShow:(NEShowModel *)show;

- (NEListModel *)replaceShow:(NEShowModel *)oldShow withShow:(NEShowModel *)newShow;

- (NEListModel *)addEpisode:(NEEpisodeModel *)episode;

- (NEListModel *)removeEpisode:(NEEpisodeModel *)episode;

- (NEListModel *)replaceEpisode:(NEEpisodeModel *)oldEpisode withEpisode:(NEEpisodeModel *)newEpisode;

@end
