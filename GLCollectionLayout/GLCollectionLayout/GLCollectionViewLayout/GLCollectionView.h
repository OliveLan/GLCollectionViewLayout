//
//  GLCollectionView.h
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLCollectionView : UIView

/**
 *   设置整个头部区域高度
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 *   设置头部collectionView的高度
 */
@property (nonatomic, assign) CGFloat collectionViewHeight;

/**
 *   设置整个头部区域背景色
 */
@property (nonatomic, strong) UIColor *headerBGColor;

/**
 *   设置卡片文本的数组
 */
@property (nonatomic, strong) NSArray *collectionViewTextArr;

/**
 *   用于存放每个卡片颜色的数组
 */
@property (nonatomic, strong) NSArray *cardColorArr;

/**
 *   存放所有tableview所需数据的数组（数组结构如Demo中ViewController所写）
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 *   当前展示第几个卡片，默认为第一个
 */
@property (nonatomic, assign) NSInteger pageInteger;

/**
 *   设置卡片是否可循环滑动
 */
@property (nonatomic, assign) BOOL isCardNeedCirculation;

@end
