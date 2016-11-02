//
//  LinearCollectionViewLayout.m
//  Maizuo3.0
//
//  Created by Olive on 16/9/18.
//  Copyright © 2016年 Tracy_deng. All rights reserved.
//

#import "LinearCollectionViewLayout.h"

#define spacing 15.f


@implementation LinearCollectionViewLayout
{
    CGFloat insert;    //内边距
}
#pragma mark - 初始化布局
-(void)prepareLayout{
    [super prepareLayout];
    self.minimumInteritemSpacing = 16;
    self.minimumLineSpacing = 16;
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置内边距
    insert =(self.collectionView.frame.size.width-self.itemSize.width)/2;
    self.sectionInset =UIEdgeInsetsMake(0, insert, 0, insert);
    
}

/**
 *  设置cell的缩放范围比例，用返回的数组存放
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    //计算CollectionView最中心的x值
    CGFloat centetX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        //取cell的中心点和collectionview中心点差值的绝对值
        CGFloat delta = ABS(attrs.center.x - centetX);
        //计算cell的动态缩放的比例
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width*0.55;
        //最小比例
        CGFloat minScale = 1 - (spacing+self.itemSize.width)/self.collectionView.frame.size.width*0.55;
        //设置缩放比例
        if (delta == 0) {
            attrs.transform = CGAffineTransformMakeScale(1, 1);
        }else{
            if (delta <= (spacing+self.itemSize.width)) {
                //缩小的item与正常item高度差值
                CGFloat y   = self.itemSize.height*(1-scale);
                attrs.frame = CGRectMake(attrs.frame.origin.x, attrs.frame.origin.y+y, attrs.frame.size.width, attrs.frame.size.height-y);
            }else{
                CGFloat y   = self.itemSize.height*(1-minScale);
                attrs.frame = CGRectMake(attrs.frame.origin.x, attrs.frame.origin.y+y, attrs.frame.size.width, attrs.frame.size.height-y);
            }
        }
        
    }
    return array;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出 最终显示的矩形框
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size     = self.collectionView.frame.size;
    
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
    CGFloat centerX = self.collectionView.frame.size.width /2+ proposedContentOffset.x;
    //存放的最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
    return proposedContentOffset;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
