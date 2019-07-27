//
//  FavouritesCollectionViewCell.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 28/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "FavouritesCollectionViewCell.h"

@interface FavouritesCollectionViewCell ()

@end

@implementation FavouritesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [_label.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [_label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
    [_label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5].active = YES;
    [_label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5].active = YES;
    _label.backgroundColor = UIColor.greenColor;
    return self;
}

@end
