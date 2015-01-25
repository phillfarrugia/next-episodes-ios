//
//  NEShowTableViewCell2.m
//  Next Episodes
//
//  Created by Phill Farrugia on 24/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NEShowTableViewCell.h"
#import "NEShowCellViewModel.h"
#import "UIImageView+AFNetworking.h"

@interface NEShowTableViewCell ()

@property (nonatomic) NEShowCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *overview;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *runtime;
@property (weak, nonatomic) IBOutlet UILabel *airdate;

@property (weak, nonatomic) IBOutlet UIImageView *poster;

@property (nonatomic, readwrite) CGFloat height;

@end

@implementation NEShowTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(NEShowCellViewModel *)viewModel
{
    if (_viewModel != viewModel) {
        _viewModel = viewModel;
        
        [self setupSubViews];
    }
}

- (void)setupSubViews
{
    self.title.text = self.viewModel.title;
    self.status.text = self.viewModel.status;
    self.runtime.text = self.viewModel.runtime;
    self.airdate.text = self.viewModel.airdate;
    self.overview.text = self.viewModel.overview;
    [self.overview setNumberOfLines:2];
    
    [self.poster sd_setImageWithURL:self.viewModel.poster placeholderImage:[UIImage imageNamed:@"Poster Placeholder"]];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.poster mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(super.mas_top).with.offset(5.0f);
        make.leading.equalTo(super.mas_leading).with.offset(5.0f);
        make.height.equalTo(@90);
        make.width.equalTo(@60);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(super.mas_top).with.offset(12.5f);
        make.leading.equalTo(self.poster.mas_trailing).with.offset(10.0f);
        make.width.greaterThanOrEqualTo(@100).with.priorityLow();
    }];
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(3.0f);
        make.leading.equalTo(self.title.mas_leading).with.offset(0.0f);
        make.width.greaterThanOrEqualTo(@50);
    }];

    [self.runtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(3.0f);
        make.leading.equalTo(self.status.mas_trailing).with.offset(5.0f);
        make.baseline.equalTo(self.status.mas_baseline).with.offset(0.0f);
        make.width.greaterThanOrEqualTo(@50);
    }];

    [self.overview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(super.mas_width);
        make.leading.equalTo(self.title.mas_leading).with.offset(0.0f);
        make.trailing.equalTo(super.mas_right).with.offset(-20.0f);
        make.top.equalTo(self.status.mas_bottom).with.offset(3.0f);
    }];
    
    [self.airdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(super.mas_right).with.offset(-10.0f).with.priorityHigh();
        make.baseline.equalTo(self.title.mas_baseline).with.offset(0.0f);
        make.leading.equalTo(self.title.mas_trailing).with.offset(5.0f).with.priorityHigh();
        make.width.greaterThanOrEqualTo(@135).with.priorityHigh();
    }];
}

@end
