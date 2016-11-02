//
//  GLCollectionView.m
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import "GLCollectionView.h"
#import "GLCollectionViewCell.h"
#import "LinearCollectionViewLayout.h"
#import "GLTableView.h"

#define Screen_Width   self.frame.size.width
#define Screen_Height  self.frame.size.height
#define cardWidth      90
#define cardSpacing    16

@interface GLCollectionView()<UICollectionViewDelegate ,UICollectionViewDataSource>

/**
 *   顶部用于承载可滑动的collectionView
 */
@property (nonatomic, strong) UIView * headerView;

/**
 *   可滑动的collectionView
 */
@property (nonatomic, strong) UICollectionView * headCollectionView;

/**
 *   下方用于承载tableview的左右滑动的scrollView
 */
@property (nonatomic, strong) UIScrollView * bottomScrollView;

/**
 *   继承于UICollectionViewFlowLayout
 */
@property (nonatomic, strong) LinearCollectionViewLayout * linearLayout;

/**
 *   卡片数量
 */
@property (nonatomic, assign) NSInteger cardNumber;

/**
 *   下方所有tableview的数据源
 */
@property (nonatomic, strong) NSMutableArray *tableViewDataSource;

/**
 *   所有卡片数据源
 */
@property (nonatomic, strong) NSMutableArray *cardDataSource;

/**
 *   所有卡片颜色数据源
 */
@property (nonatomic, strong) NSMutableArray *cardColorDataSource;
@end


@implementation GLCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self commonInit];
}
#pragma mark - init

- (void)commonInit{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, _headerHeight)];
    _headerView.backgroundColor = _headerBGColor;
    
    _cardNumber = _isCardNeedCirculation?_collectionViewTextArr.count*3:_collectionViewTextArr.count;
    _tableViewDataSource = [NSMutableArray array];
    _cardDataSource      = [NSMutableArray array];
    _cardColorDataSource = [NSMutableArray array];
    
    int k = _isCardNeedCirculation?3:0;
    for (int i = 0; i < k; i++) {
        for (id dataSource in _dataSource) {
            [_tableViewDataSource addObject:dataSource];
        }
        for (id dataSource in _collectionViewTextArr) {
            [_cardDataSource addObject:dataSource];
        }
        for (id dataSource in _cardColorArr) {
            [_cardColorDataSource addObject:dataSource];
        }
    }
    
    [self addSubview:_headerView];
    [self addHeadCollectionView];
    [self addBottomScrollView];
}

- (void)addHeadCollectionView{
    if (nil == _headCollectionView) {

        _headCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (_headerView.frame.size.height-_collectionViewHeight)/2, Screen_Width, _collectionViewHeight) collectionViewLayout:self.linearLayout];
        _headCollectionView.delegate   = self;
        _headCollectionView.dataSource = self;
        _headCollectionView.backgroundColor = [UIColor clearColor];
        _headCollectionView.showsHorizontalScrollIndicator = NO;
        [_headerView addSubview:_headCollectionView];
        
        [_headCollectionView registerNib:[UINib nibWithNibName:@"GLCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GLCollectionViewCell"];
        dispatch_async(dispatch_get_main_queue(),^{
            _linearLayout.collectionView.contentOffset = CGPointMake((_pageInteger+5)*(cardWidth+cardSpacing), 0);
        });
        _headCollectionView.decelerationRate = 0;
    }
}

- (void)addBottomScrollView{
    if (nil == _bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headerHeight+_headerView.frame.origin.y, Screen_Width, Screen_Height-_headerHeight+_headerView.frame.origin.y)];
        _bottomScrollView.contentSize   = CGSizeMake(_cardNumber * Screen_Width, 0);
        _bottomScrollView.bounces       = YES;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.scrollEnabled = NO;
        _bottomScrollView.showsVerticalScrollIndicator   = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        for (int item = 0; item < _cardNumber; item++) {
            GLTableView * tableView = [[GLTableView alloc]initWithFrame:CGRectMake(item * Screen_Width, 0, Screen_Width, Screen_Height-_headerHeight-_headerView.frame.origin.y) style:UITableViewStylePlain];
            if (_tableViewDataSource.count > 0) {
                NSArray *data = _tableViewDataSource[item];
                tableView.pageInteger = _pageInteger;
                tableView.dataArr = data;
            }
            [_bottomScrollView addSubview:tableView];
        }
        [self addSubview:_bottomScrollView];
    }
}

#pragma mark - layout

-(LinearCollectionViewLayout *)linearLayout{
    if (!_linearLayout) {
        _linearLayout = [[LinearCollectionViewLayout alloc]init];
        _linearLayout.itemSize = CGSizeMake(cardWidth, 75);
    }
    return _linearLayout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cardNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"GLCollectionViewCell";
    GLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text  = _cardDataSource[indexPath.row];
    cell.backgroundColor = _cardColorDataSource[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_headCollectionView setContentOffset:CGPointMake(indexPath.row*(cardWidth+cardSpacing), 0) animated:YES];
    [self changeCardToPageInteger:indexPath.row+1 animated:YES];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        [self changeCardToPageInteger:scrollView.contentOffset.x/(cardWidth+cardSpacing)+1 animated:NO];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        CGFloat x = Screen_Width*scrollView.contentOffset.x/(cardWidth+cardSpacing);
        [_bottomScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
        
        if (_isCardNeedCirculation) {
            //实现卡片无限滑动
            if (_headCollectionView.contentOffset.x >= cardWidth*(_cardNumber-3) + cardSpacing*(_cardNumber-3)) {
                [_headCollectionView setContentOffset:CGPointMake(cardWidth*(_collectionViewTextArr.count+2)+cardSpacing*(_collectionViewTextArr.count+2), 0) animated:NO];
                [_bottomScrollView setContentOffset:CGPointMake((_collectionViewTextArr.count+2)*Screen_Width, 0) animated:NO];
            }else if(_headCollectionView.contentOffset.x <= cardWidth*2 + cardSpacing*2){
                [_headCollectionView setContentOffset:CGPointMake(cardWidth*(_collectionViewTextArr.count+2)+cardSpacing*(_collectionViewTextArr.count+2), 0) animated:NO];
                [_bottomScrollView setContentOffset:CGPointMake((_collectionViewTextArr.count+2)*Screen_Width, 0) animated:NO];
            }
        }
    }
}

#pragma mark - changeCard
- (void)changeCardToPageInteger:(NSInteger)pageInteger animated:(BOOL)animated{
    if (pageInteger >= 1) {
        _pageInteger = pageInteger;
        [_bottomScrollView setContentOffset:CGPointMake((pageInteger-1)*Screen_Width, 0) animated:animated];
    }
}

@end
