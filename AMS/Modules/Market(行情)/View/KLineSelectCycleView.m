//
//  KLineSelectCycleView.m
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "KLineSelectCycleView.h"
#import "KlineSelectCycleCollectionViewCell.h"
@interface KLineSelectCycleView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign) BOOL isShowing;
@end

static NSString * identifier = @"KlineSelectCycleCollectionViewCell";
@implementation KLineSelectCycleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KlineSelectCycleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
}

-(void)configData:(NSArray *)datas{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:datas];
    CGFloat selectCycleViewHeight = (self.dataArray.count/ 5+1) *47 + (self.dataArray.count - 1) /5;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(selectCycleViewHeight);
    }];
    [self.collectionView reloadData];
}

-(void)show{
    if (!self.isShowing) {
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [kAppWindow addSubview:self];
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = [UIScreen mainScreen].bounds;
//            self.backgroundColor = kBlackColor;
            self.alpha = 1;
        }completion:^(BOOL finished) {
            if (finished) {
                self.isShowing = YES;
            }
        }];
    }
}

-(void)hide{
    if (self.isShowing) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
            
        }completion:^(BOOL finished) {
            if (finished) {
                self.isShowing = false;
                [self removeFromSuperview];
            }
        }];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KScreenWidth-4)/5, 47);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KlineSelectCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.nameLabel.text = dict[@"name"];
    cell.backgroundColor = self.currentSelectIndex == indexPath.row ? [UIColor zj_colorWithHexString:@"#4899FF" alpha:1] : kCellBackGroundColor;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentSelectIndex != indexPath.row) {
        _currentSelectIndex = indexPath.row;
        [self.collectionView reloadData];
        if (self.didSelectCycleViewItemBlock) {
            self.didSelectCycleViewItemBlock(self.dataArray[indexPath.row]);
        }
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

@end
