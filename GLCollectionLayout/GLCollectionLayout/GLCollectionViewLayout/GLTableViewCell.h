//
//  GLTableViewCell.h
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

- (void)setData:(id)data;

@end
