//
//  GLCollectionViewCell.m
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import "GLCollectionViewCell.h"

@implementation GLCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
    self.clipsToBounds      = YES;
}

@end
