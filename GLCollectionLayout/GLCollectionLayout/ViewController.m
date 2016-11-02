//
//  ViewController.m
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import "ViewController.h"
#import "GLCollectionView.h"

#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ViewController ()
{
    NSArray *_collectionViewTextArr;
    NSArray *_cardColorArr;
    NSMutableArray *_dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    GLCollectionView *collectionView = [[GLCollectionView alloc]initWithFrame:self.view.bounds];
    
    collectionView.headerHeight          = 135.f;
    collectionView.collectionViewHeight  = 80.f;
    collectionView.headerBGColor         = [UIColor orangeColor];
    collectionView.collectionViewTextArr = _collectionViewTextArr;
    collectionView.cardColorArr          = _cardColorArr;
    collectionView.dataSource            = _dataSource;
    collectionView.isCardNeedCirculation = YES;
    
    [self.view addSubview:collectionView];
    
}

- (void)setData{
    
    _collectionViewTextArr = @[@"Card1",@"Card2",@"Card3",@"Card4",@"Card5"];
    
    _cardColorArr = [NSArray arrayWithObjects:
                    RGBACOLOR(81, 227, 194, 1),RGBACOLOR(255, 126, 145, 1),RGBACOLOR(244, 217, 114, 1),RGBACOLOR(83, 202, 218, 1),RGBACOLOR(250, 145, 124, 1),nil];
    
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSMutableArray *data2 = [NSMutableArray array];
        for (int j = 0; j < i+1; j++) {
            NSString *str = [NSString stringWithFormat:@"第%d个卡片，第%d行",i+1,j+1];
            [data2 addObject:str];
        }
        [_dataSource addObject:data2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
