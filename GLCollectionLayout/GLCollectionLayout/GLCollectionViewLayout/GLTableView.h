//
//  GLTableView.h
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLTableView : UITableView


/**
 *    当前选中item的index
 */
@property (nonatomic, assign)NSInteger    pageInteger;

/**
 *    传入当前tableview所需展示的数据数组
 */
@property (nonatomic, strong)NSArray     *dataArr;


@end
