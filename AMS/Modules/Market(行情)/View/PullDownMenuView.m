//
//  PullDownMenuView.m
//  AMS
//
//  Created by jianlu on 2018/11/15.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "PullDownMenuView.h"
#import "PullDownMenuCollectionViewCell.h"
@interface PullDownMenuView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property(nonatomic,strong) UICollectionView * collectView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,assign) NSInteger currentSelectIndex;
@end

#define identifier @"PullDownMenuViewCell"
@implementation PullDownMenuView

-(instancetype) initWithFrame:(CGRect)frame dataArray:(NSArray*) array{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kNavBackGroundColor;
        [self addSubview:self.collectView];
    }
    return self;
}

-(UICollectionView *)collectView{
    if (!_collectView) {
        //初始化layout
        UICollectionViewFlowLayout *layout =  [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((KScreenWidth - 50) /3, 30);
        layout.minimumInteritemSpacing = 15;
        layout.minimumLineSpacing = 20;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectView.backgroundColor = kCellBackGroundColor;
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([PullDownMenuCollectionViewCell class]) bundle:nil]  forCellWithReuseIdentifier:identifier];
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void) updateCollectionHeight:(NSArray *) array{
   
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo([PullDownMenuView heightOfMenuView:array]);
    }];
}
+(CGFloat)heightOfMenuView:(NSArray *)array{
    CGFloat collectionHeight = 40 +((array.count - 1) /3
                                    +1)*30+(array.count - 1) /3*20;
    
    CGFloat height = MIN(KScreenHeight - kTabBarHeight - kTopHeight - 10, collectionHeight);
    return height;
}

-(void)ConfigData:(NSArray *)array firstShow:(BOOL)show{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    if (show) {
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.height.mas_equalTo([PullDownMenuView heightOfMenuView:array]);
        }];
    }else{
        [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([PullDownMenuView heightOfMenuView:array]);
        }];
    }
        
    [self.collectView reloadData];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PullDownMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    [cell.menuBtn setTitle:dict[@"name"] forState:UIControlStateNormal];
    [cell setSelect:indexPath.row == self.currentSelectIndex];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.row];
//    PullDownMenuCollectionViewCell *cell  = ( PullDownMenuCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.currentSelectIndex != indexPath.row) {
        self.currentSelectIndex = indexPath.row;
        if (self.menuCellTapBlock) {
            self.menuCellTapBlock(dict);
        }
        [self.collectView reloadData];
    }
    
//    NSLog(@"点击了%@",dict[@"name"]);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
