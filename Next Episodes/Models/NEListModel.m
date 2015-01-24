//
//  NEListModel.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEListModel.h"

@interface NEListModel ()

@property (readwrite) NSArray *shows;
@property (readwrite) NSArray *episodes;

@end

@implementation NEListModel

- (instancetype)initWithStandardValues
{
    self.shows = @[];
    self.episodes = @[];
    
    return self;
}

- (NEListModel *)addShow:(NEShowModel *)show
{
    if ([self.shows containsObject:show]) {
        return self;
    }
    
    NSMutableArray *shows = [self.shows mutableCopy];
    [shows insertObject:show atIndex:0];
    
    NEListModel *listModel = [self copy];
    listModel.shows = [NSArray arrayWithArray:shows];
    
    return listModel;
}

- (NEListModel *)removeShow:(NEShowModel *)show
{
    NSAssert([self.shows containsObject:show], @"self.shows must contain show");
    
    NSMutableArray *shows = [self.shows mutableCopy];
    [shows removeObject:show];
    
    NEListModel *listModel = [self copy];
    listModel.shows = [NSArray arrayWithArray:shows];
    
    return listModel;
}

- (NEListModel *)replaceShow:(NEShowModel *)oldShow withShow:(NEShowModel *)newShow
{
    NSInteger index = [self.shows indexOfObject:oldShow];
    
    if (index == NSNotFound) {
        return self;
    }
    
    NSMutableArray *shows = [self.shows mutableCopy];
    [shows replaceObjectAtIndex:index withObject:newShow];
    
    NEListModel *listModel = [self copy];
    listModel.shows = [NSArray arrayWithArray:shows];
    
    return listModel;
}

- (NEListModel *)addEpisode:(NEEpisodeModel *)episode
{
    if ([self.episodes containsObject:episode]) {
        return self;
    }
    
    NSMutableArray *episodes = [self.episodes mutableCopy];
    [episodes insertObject:episode atIndex:0];
    
    NEListModel *listModel = [self copy];
    listModel.episodes = [NSArray arrayWithArray:episodes];
    
    return listModel;
}

- (NEListModel *)removeEpisode:(NEEpisodeModel *)episode
{
    NSAssert([self.episodes containsObject:episode], @"episodes must contain episode");
    
    NSMutableArray *episodes = [self.episodes mutableCopy];
    [episodes removeObject:episode];
    
    NEListModel *listModel = [self copy];
    listModel.episodes = [NSArray arrayWithArray:episodes];
    
    return listModel;
}

- (NEListModel *)replaceEpisode:(NEEpisodeModel *)oldEpisode withEpisode:(NEEpisodeModel *)newEpisode
{
    NSInteger index = [self.episodes indexOfObject:oldEpisode];
    
    if (index == NSNotFound) {
        return self;
    }
    
    NSMutableArray *episodes = [self.episodes mutableCopy];
    [episodes replaceObjectAtIndex:index withObject:newEpisode];
    
    NEListModel *listModel = [self copy];
    listModel.episodes = [NSArray arrayWithArray:episodes];
    
    return listModel;
}

@end
