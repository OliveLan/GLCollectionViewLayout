//
//  GLTableView.m
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//


#import "GLTableView.h"
#import "GLTableViewCell.h"  /*根据实际所需的cell替换*/


@interface GLTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GLTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate   = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"GLTableViewCell" bundle:nil] forCellReuseIdentifier:@"GLTableViewCell"];
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GLTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"GLTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:_dataArr[indexPath.row]];
    return cell;
    
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
