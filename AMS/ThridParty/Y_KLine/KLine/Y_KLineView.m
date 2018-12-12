//
//  Y_KLineView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineView.h"
#import "Y_KLineMainView.h"
#import "Y_KLineMAView.h"
#import "Y_VolumeMAView.h"
#import "Y_AccessoryMAView.h"
#import "Y_BollMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineVolumeView.h"
#import "Y_StockChartRightYView.h"
#import "Y_KLineAccessoryView.h"
#import "Y_KLine_TimeView.h"
#import "KLineLongTapParamView.h"
@interface Y_KLineView() <UIScrollViewDelegate, Y_KLineMainViewDelegate, Y_KLineVolumeViewDelegate, Y_KLineAccessoryViewDelegate,UIGestureRecognizerDelegate>
/**
 *  时间
 */
@property (nonatomic, strong) Y_KLine_TimeView *kLineTimeView;

/**
 *  右侧涨跌幅
 */
@property (nonatomic, strong) Y_StockChartRightYView *riseFallPerView;

/**
 *  右侧价格图
 */
@property (nonatomic, strong) Y_StockChartRightYView *priceView;

/**
 *  右侧成交量图
 */
@property (nonatomic, strong) Y_StockChartRightYView *volumeView;

/**
 *  右侧Accessory图
 */
@property (nonatomic, strong) Y_StockChartRightYView *accessoryView;

/**
 *  旧的scrollview准确位移
 */
@property (nonatomic, assign) CGFloat oldExactOffset;

/**
 *  kLine-MAView
 */
@property (nonatomic, strong) Y_KLineMAView *kLineMAView;

/**
 *  kLine-MAView
 */
@property (nonatomic, strong) Y_BollMAView *kBollMAView;

/**
 *  Volume-MAView
 */
@property (nonatomic, strong) Y_VolumeMAView *volumeMAView;

/**
 *  Accessory-MAView
 */
@property (nonatomic, strong) Y_AccessoryMAView *accessoryMAView;

/**
 *  长按后显示的View
 */
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UIView *horizontalView;
@property (nonatomic, strong) KLineLongTapParamView* paramView;

@property (nonatomic, strong) MASConstraint *kLineMainViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *kLineVolumeViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *priceViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *volumeViewHeightConstraint;

@property (nonatomic,assign) BOOL isAnimation;

/**
 * 需要绘制的K线位置数组
 */
@property (nonatomic, strong) NSArray *needDrawKLinePositionModels;
@property (nonatomic, strong) NSArray *needDrawKLineModels;
@end

@implementation Y_KLineView

//initWithFrame设置视图比例
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.lastDayClosepPrice = @2000;
    }
    return self;
}

- (Y_KStockScrollView*) scrollView
{
    if(!_scrollView)
    {
        _scrollView = [Y_KStockScrollView new];

        _scrollView.stockType = self.MainViewType;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.backgroundColor = [UIColor backgroundColor];
        //        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            //缩放手势
            UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
            [_scrollView addGestureRecognizer:pinchGesture];
        }
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self layoutIfNeeded];
    }
    return _scrollView;
}
//main指标
- (Y_KLineMAView *)kLineMAView
{
    if (!_kLineMAView && self.MainViewType == Y_StockChartcenterViewTypeKline) {
        _kLineMAView = [Y_KLineMAView view];
        _kLineMAView.backgroundColor =[UIColor backgroundColor];
        [self addSubview:_kLineMAView];
        [_kLineMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(@1);
            make.height.mas_equalTo(MAIN_MAVIEW_HEADER);
        }];
    }
    return _kLineMAView;
}
//Main图
-(Y_KLineMainView *)kLineMainView
{
    if (!_kLineMainView && self) {
        _kLineMainView = [Y_KLineMainView new];
        _kLineMainView.backgroundColor = kClearColor;
        _kLineMainView.delegate = self;
        _kLineMainView.MainViewType = self.MainViewType;
        [_kLineMainView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            if ([self.delegate respondsToSelector:@selector(y_KlineViewDidtapEvent: )]) {
                [self.delegate y_KlineViewDidtapEvent:MainView];
            }
        }];
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
                self.mainViewRatio = [Y_StockChartGlobalVariable kLineMainViewRadio];
                make.top.equalTo(@1);
            }else{
                self.mainViewRatio = 0.64;
                make.top.equalTo(@1);
            }
            make.left.equalTo(self.scrollView);
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
            make.width.equalTo(@0);
        }];
        
    }
    //加载rightYYView
    self.priceView.backgroundColor = [UIColor clearColor];
    self.riseFallPerView.backgroundColor = [UIColor clearColor];
    return _kLineMainView;
}
//成交量指标
- (Y_VolumeMAView *)volumeMAView
{
    if (!_volumeMAView) {
        _volumeMAView = [Y_VolumeMAView view];
        [self addSubview:_volumeMAView];
        [_volumeMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineMainView.mas_bottom);
            make.height.equalTo(@MAIN_MAVIEW_HEADER);
        }];
    }
    return _volumeMAView;
}

//成交量指标
- (Y_BollMAView *)kBollMAView
{
    if (!_kBollMAView && self.MainViewType == Y_StockChartcenterViewTypeKline) {
        _kBollMAView = [Y_BollMAView view];
        _kBollMAView.backgroundColor = [UIColor backgroundColor];
        [self addSubview:_kBollMAView];
        [_kBollMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(@1);
            make.height.mas_equalTo(MAIN_MAVIEW_HEADER);
        }];
    }
    return _kBollMAView;
}

- (Y_KLineVolumeView *)kLineVolumeView
{
    if(!_kLineVolumeView && self)
    {
        _kLineVolumeView = [Y_KLineVolumeView new];
        _kLineVolumeView.delegate = self;
        _kLineVolumeView.backgroundColor = kClearColor;
        _kLineVolumeView.type = self.MainViewType;
        [_kLineVolumeView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            if ([self.delegate respondsToSelector:@selector(y_KlineViewDidtapEvent: )]) {
                [self.delegate y_KlineViewDidtapEvent:VolView];
            }
        }];
        [self.scrollView addSubview:_kLineVolumeView];
        [_kLineVolumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.volumeMAView.mas_bottom);
            make.width.equalTo(self.kLineMainView.mas_width);
            if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
                self.volumeViewRatio = [Y_StockChartGlobalVariable kLineVolumeViewRadio]; make.height.equalTo(self.scrollView.mas_height).multipliedBy(self.volumeViewRatio);
            }else{
                make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
            }
        }];
        [self layoutIfNeeded];
    }
    self.volumeView.backgroundColor = [UIColor clearColor];
    return _kLineVolumeView;
}
//辅助线指标
- (Y_AccessoryMAView *)accessoryMAView
{
    if(!_accessoryMAView && self.MainViewType == Y_StockChartcenterViewTypeKline) {
        _accessoryMAView = [Y_AccessoryMAView new];
        [self addSubview:_accessoryMAView];
        [_accessoryMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineVolumeView.mas_bottom);
            make.height.equalTo(@MAIN_MAVIEW_HEADER);
        }];
    }
    return _accessoryMAView;
}

- (Y_KLineAccessoryView *)kLineAccessoryView
{
    if(!_kLineAccessoryView && self.MainViewType == Y_StockChartcenterViewTypeKline)
    {
        _kLineAccessoryView = [Y_KLineAccessoryView new];
        _kLineAccessoryView.backgroundColor = kClearColor;
        _kLineAccessoryView.delegate = self;
        [_kLineAccessoryView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            if ([self.delegate respondsToSelector:@selector(y_KlineViewDidtapEvent: )]) {
                [self.delegate y_KlineViewDidtapEvent:AccessoryView];
            }
        }];
        [self.scrollView addSubview:_kLineAccessoryView];
        [_kLineAccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineVolumeView);
            make.top.equalTo(self.accessoryMAView.mas_bottom);
            make.width.equalTo(self.kLineVolumeView.mas_width);
            make.bottom.equalTo(self).offset(-20);
        }];
        [self layoutIfNeeded];
    }
    self.accessoryView.backgroundColor = [UIColor clearColor];
    return _kLineAccessoryView;
}

//时间
-(Y_KLine_TimeView *)kLineTimeView{
    if (!_kLineTimeView) {
        _kLineTimeView = [Y_KLine_TimeView new];
        _kLineTimeView.type = self.MainViewType;
        [self.scrollView addSubview:_kLineTimeView];
        [_kLineTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineVolumeView);
            make.width.equalTo(self.kLineVolumeView.mas_width);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.height.mas_equalTo(20);
        }];
        [self layoutIfNeeded];
    }
    return _kLineTimeView;
}
//价格
- (Y_StockChartRightYView *)priceView
{
    if(!_priceView)
    {
        _priceView = [Y_StockChartRightYView new];
        _priceView.type = self.MainViewType;
        [self insertSubview:_priceView aboveSubview:self.scrollView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineMainView).offset(LeftXViewPadding);
            make.left.equalTo(self.mas_left);
            make.width.equalTo(@(Y_StockChartKLinePriceViewWidth));
            make.bottom.equalTo(self.kLineMainView.mas_bottom).offset(-LeftXViewPadding);
        }];
    }
    return _priceView;
}

//价格
- (Y_StockChartRightYView *)riseFallPerView{
    if(!_riseFallPerView && self.MainViewType == Y_StockChartcenterViewTypeTimeLine){
        _riseFallPerView = [Y_StockChartRightYView new];
        _riseFallPerView.type = self.MainViewType;
        _riseFallPerView.isRisePer = YES;
        [self insertSubview:_riseFallPerView aboveSubview:self.scrollView];
        [_riseFallPerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineMainView).offset(LeftXViewPadding);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@(Y_StockChartKLinePriceViewWidth));
            make.bottom.equalTo(self.kLineMainView.mas_bottom).offset(-LeftXViewPadding);
        }];
    }
    return _riseFallPerView;
}
//成交量左侧
- (Y_StockChartRightYView *)volumeView
{
    if(!_volumeView)
    {
        _volumeView = [Y_StockChartRightYView new];
        _volumeView.chartType = VolumeType;
        [self insertSubview:_volumeView aboveSubview:self.scrollView];
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineVolumeView.mas_top).offset(LeftXViewPadding);
            make.right.width.equalTo(self.priceView);
            //            make.height.equalTo(self).multipliedBy(self.volumeViewRatio);
            make.bottom.equalTo(self.kLineVolumeView).offset(-LeftXViewPadding);
        }];
    }
    return _volumeView;
}
//辅助线左侧
- (Y_StockChartRightYView *)accessoryView
{
    if(!_accessoryView && self.MainViewType ==  Y_StockChartcenterViewTypeKline)
    {
        _accessoryView = [Y_StockChartRightYView new];
        _accessoryView.chartType = MACDType;
        [self insertSubview:_accessoryView aboveSubview:self.scrollView];
        [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineAccessoryView.mas_top).offset(LeftXViewPadding);
            make.right.width.equalTo(self.volumeView);
            make.bottom.equalTo(self.kLineAccessoryView.mas_bottom).offset(-LeftXViewPadding);
        }];
    }
    return _accessoryView;
}
#pragma mark - set方法

#pragma mark kLineModels设置方法
- (void)setKLineModels:(NSArray *)kLineModels
{
    if(!kLineModels) {
        return;
    }
    _kLineModels = kLineModels;
    [self private_drawKLineMainView];
    if(self.MainViewType == Y_StockChartcenterViewTypeKline){
        //设置contentOffset
        CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] ;
        CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
        if (offset > 0)
        {
            self.scrollView.contentOffset = CGPointMake(offset, 0);
        } else {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
    }else{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    Y_KLineModel *model = [kLineModels lastObject];
    if (self.targetLineStatus == Y_StockChartTargetLineStatusMA) {
        [self.kLineMAView maProfileWithModel:model];
    }
    
    if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
        [self.kBollMAView maProfileWithModel:model];
    }
    
    [self.volumeMAView maProfileWithModel:model];

    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        self.accessoryMAView.targetLineStatus = self.targetLineStatus;
        [self.accessoryMAView maProfileWithModel:model];
    }
}
- (void)setTargetLineStatus:(Y_StockChartTargetLineStatus)targetLineStatus
{
    _targetLineStatus = targetLineStatus;
    //
    ////    if(targetLineStatus < 103)
    ////    {
    //        if(targetLineStatus == Y_StockChartTargetLineStatusAccessoryClose){
    //
    //            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.65];
    //            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.28];
    //
    //        } else {
    //            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.5];
    //            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.2];
    //
    //        }
    //
    //        [self.kLineMainViewHeightConstraint uninstall];
    //        [_kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy([Y_StockChartGlobalVariable kLineMainViewRadio]);
    //        }];
    //        [self.kLineVolumeViewHeightConstraint uninstall];
    //        [self.kLineVolumeView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy([Y_StockChartGlobalVariable kLineVolumeViewRadio]);
    //        }];
    if (_targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
        [self.kBollMAView setHidden:NO];
        [self.kLineMAView setHidden:YES];
        [self reDraw];
        [self.kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(MAIN_MAVIEW_HEADER + 1);
        }];
    }else if(_targetLineStatus == Y_StockChartTargetLineStatusMA){
        [self.kBollMAView setHidden:YES];
        [self.kLineMAView setHidden:NO];
        [self reDraw];
        [self.kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(MAIN_MAVIEW_HEADER + 1);
        }];
    }else if(_targetLineStatus == Y_StockChartTargetLineStatusMACD){
        if (_kBollMAView !=nil) {
             [self.kBollMAView setHidden:YES];
        }
        if (_kLineMAView !=nil) {
            [self.kLineMAView setHidden:YES];
        }
        
        [self reDraw];
        [self.kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(1);
        }];
    }
    
//    [self reDraw];
}
#pragma mark - event事件处理方法
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch
{
//    //1.获取缩放倍数
//    static CGFloat oldScale = 1.0f;
//    CGFloat difValue = pinch.scale - oldScale;
//
//    if(ABS(difValue) > Y_StockChartScaleBound) {
//        if( pinch.numberOfTouches == 2 ) {
//
//            //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
//            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
//            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
//            CGFloat centerX = (p1.x+p2.x)/2;
//
//            //3.拿到中心点数据源的index
//            CGFloat oldLeftArrCount = ABS(centerX + [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
//
//            //4.缩放重绘
//            CGFloat newLineWidth = [Y_StockChartGlobalVariable kLineWidth] * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor));
//            [Y_StockChartGlobalVariable setkLineWith:newLineWidth];
//            //            [self updateScrollViewContentWidth];
//
//            //5.计算更新宽度后捏合中心点距离klineView左侧的距离
//            CGFloat newLeftDistance = oldLeftArrCount * [Y_StockChartGlobalVariable kLineWidth] + (oldLeftArrCount - 1) * [Y_StockChartGlobalVariable kLineGap];
//
//            //6.设置scrollview的contentoffset = (5) - (2);
//            if ( self.kLineModels.count * newLineWidth + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] > self.scrollView.bounds.size.width ) {
//                CGFloat newOffsetX = newLeftDistance - (centerX - self.scrollView.contentOffset.x);
//                self.scrollView.contentOffset = CGPointMake(newOffsetX > 0 ? newOffsetX : 0 , self.scrollView.contentOffset.y);
//            } else {
//                self.scrollView.contentOffset = CGPointMake(0 , self.scrollView.contentOffset.y);
//            }
//            //更新contentsize
//            [self.kLineMainView updateMainViewWidth];
//            [self setNeedsDisplay];
//        }
//    }
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = [Y_StockChartGlobalVariable kLineWidth];
        CGFloat oldKLineGap = [Y_StockChartGlobalVariable kLineGap];
        if (oldKLineWidth == Y_StockChartKLineMinWidth && difValue <= 0)
        {
            return;
        }
        
        NSInteger oldNeedDrawStartIndex = [self.kLineMainView getNeedDrawStartIndexWithScroll:NO];
        
        [Y_StockChartGlobalVariable setkLineWith:oldKLineWidth * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        
        if( pinch.numberOfTouches == 2 ) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
            
            self.kLineMainView.pinchStartIndex = oldNeedDrawStartIndex + oldLeftArrCount - newLeftArrCount;
        }
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        [self.kLineMainView drawMainView];
    }
}


#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
//    NSLog(@"进入长按");
//
//
//    NSLog(@"%f", [longPress locationInView:self.scrollView].x - self.scrollView.contentOffset.x);
    
    
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        
        CGPoint location = [longPress locationInView:self.scrollView];
        if (location.x < 0 || location.x > self.scrollView.contentSize.width) return;
        

//        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
//            if(ABS(oldPositionX - location.x) < ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]))
//            {
//                return;
//            }
//
//        }
//
        //暂停滑动
        self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;

        //更新竖线位置
        CGFloat yValue = 0.f;
        
        if (location.y >= CGRectGetMinY(self.kLineMainView.frame) && location.y <= CGRectGetMaxY(self.kLineMainView.frame)) {
            yValue = [self.kLineMainView getYValue:location.y];
        }else if (location.y >= CGRectGetMinY(self.kLineVolumeView.frame) && location.y <= CGRectGetMaxY(self.kLineVolumeView.frame) ){
            yValue = [self.kLineVolumeView getYValue:location.y];
        }
        
        if(self.MainViewType == Y_StockChartcenterViewTypeKline){
            if (location.y >= CGRectGetMinY(self.kLineAccessoryView.frame) && location.y <= CGRectGetMaxY(self.kLineAccessoryView.frame) ){
                yValue = [self.kLineAccessoryView getYValue:location.y];
            }
        }

//
      CGFloat x =[self.kLineMainView getExactXPositionWithOriginXPosition:CGPointMake(location.x, yValue)];
//
//
//
        if ([self.delegate respondsToSelector:@selector(y_klineDidReachEdges:data:realX:)]) {
            [self.delegate y_klineDidReachEdges:location data:self.kLineModels.lastObject realX:x];
        }
//    }
//
//
//    //    if(longPress.state == UIGestureRecognizerStateEnded)
//    //    {
//    //
//    //        oldPositionX = 0;
//    //        //恢复scrollView的滑动
//    //        self.scrollView.scrollEnabled = NO;
//    //        Y_KLineModel *lastModel = self.kLineModels.lastObject;
//    //        [self.kLineMAView maProfileWithModel:lastModel];
//    //        [self.volumeMAView maProfileWithModel:lastModel];
//    //        [self.accessoryMAView maProfileWithModel:lastModel];
//    //        [self.paramView maProfileWithModel:lastModel];
    //
}
}

//- (NSInteger)xPosition {
//    NSInteger leftArrCount = [self startIndex];
//    CGFloat startXPosition = (leftArrCount + 1) * [Y_StockChartGlobalVariable kLineGap] + leftArrCount * [Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineWidth]/2;
//    return startXPosition;
//}
//
//- (NSInteger)startIndex {
//    CGFloat offsetX = self.scrollView.contentOffset.x < 0 ? 0 : self.scrollView.contentOffset.x;
//    //    NSUInteger leftCount = ABS(offsetX - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
//    //    NSUInteger leftCount = ceilf((offsetX - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]));
//    NSUInteger leftCount = ABS(offsetX) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
//
//    if (leftCount > self.kLineModels.count) {
//        leftCount = self.kLineModels.count - 1;
//    }
//    return leftCount;
//}

#pragma mark 重绘
- (void)reDraw
{
    self.kLineMainView.MainViewType = self.MainViewType;
    self.kLineMainView.targetLineStatus = self.targetLineStatus;
    [self.kLineMainView drawMainView];
}


#pragma mark - 私有方法
#pragma mark 画KLineMainView
- (void)private_drawKLineMainView
{
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}
- (void)private_drawKLineVolumeView
{
    NSAssert(self.kLineVolumeView, @"kLineVolume不存在");
    //更新约束
    [self.kLineVolumeView layoutIfNeeded];
    [self.kLineVolumeView draw];
}

- (void)private_drawKLineTimeView
{
    NSAssert(self.kLineTimeView, @"kLineTimeView不存在");
    //更新约束
    [self.kLineTimeView layoutIfNeeded];
    [self.kLineTimeView draw];
}
- (void)private_drawKLineAccessoryView
{
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        //更新约束
//        self.accessoryMAView.targetLineStatus = self.targetLineStatus;
//        [self.accessoryMAView maProfileWithModel:_kLineModels.lastObject];
        [self.kLineAccessoryView layoutIfNeeded];
        [self.kLineAccessoryView draw];
    }
    
}
#pragma mark VolumeView代理
- (void)kLineVolumeViewCurrentMaxVolume:(CGFloat)maxVolume minVolume:(CGFloat)minVolume
{
    self.volumeView.maxValue = maxVolume;
    self.volumeView.minValue = minVolume;
    self.volumeView.middleValue = (maxVolume - minVolume)/2 + minVolume;
}
- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice
{
    self.priceView.maxValue = maxPrice;
    self.priceView.minValue = minPrice;
    self.priceView.middleValue = (maxPrice - minPrice)/2 + minPrice;
    
    if(self.lastDayClosepPrice == nil || self.lastDayClosepPrice.floatValue == 0.f){
        self.riseFallPerView.maxValue = 0.f;
        self.riseFallPerView.minValue = 0.f;
        self.riseFallPerView.middleValue = 0.f;

    }else{
        CGFloat maxPer = (maxPrice - self.lastDayClosepPrice.floatValue)* 100/self.lastDayClosepPrice.floatValue;
        
        CGFloat minPer = (minPrice - self.lastDayClosepPrice.floatValue)* 100/self.lastDayClosepPrice.floatValue;
        
        CGFloat middlePer = (maxPer + minPer) / 2;
        
        self.riseFallPerView.maxValue = maxPer;
        self.riseFallPerView.minValue = minPer;
        self.riseFallPerView.middleValue = middlePer;
    }
}
- (void)kLineAccessoryViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue
{
    self.accessoryView.maxValue = maxValue;
    self.accessoryView.minValue = minValue;
    self.accessoryView.middleValue = (maxValue - minValue)/2 + minValue;
}
#pragma mark MainView更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels{
    if (needDrawKLineModels.count == 0) {
        return;
    }
    self.needDrawKLineModels = needDrawKLineModels;
    self.kLineVolumeView.needDrawKLineModels = needDrawKLineModels;
    self.kLineTimeView.needDrawKLineModels = needDrawKLineModels;
    
    if(self.targetLineStatus == Y_StockChartTargetLineStatusMA){
        [self.kLineMAView maProfileWithModel:needDrawKLineModels.lastObject];
    }else if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL){
        [self.kBollMAView maProfileWithModel:needDrawKLineModels.lastObject];
    }
    [self.volumeMAView maProfileWithModel:needDrawKLineModels.lastObject];
//    Y_KLineModel *model = needDrawKLineModels.lastObject;
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        self.kLineAccessoryView.needDrawKLineModels = needDrawKLineModels;
        [self.accessoryMAView maProfileWithModel:needDrawKLineModels.lastObject];
    }
}
- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels
{
    self.needDrawKLinePositionModels = needDrawKLinePositionModels;
    self.kLineVolumeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
    self.kLineAccessoryView.needDrawKLinePositionModels = needDrawKLinePositionModels;
    self.kLineTimeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}
- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors
{
    self.kLineVolumeView.kLineColors = kLineColors;
    if(self.targetLineStatus >= 103)
    {
        self.kLineVolumeView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineVolumeView];
    self.kLineAccessoryView.kLineColors = kLineColors;
    if(self.targetLineStatus < 103)
    {
        self.kLineAccessoryView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineAccessoryView];
    [self private_drawKLineTimeView];
}
-(void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel originalPosition:(CGPoint)position{
    kLineModel.yValue = position.y;
    [self.volumeMAView maProfileWithModel:kLineModel];
    [kNotificationCenter postNotificationName:kNotification_Name_Param_Update object:kLineModel];
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        [self.accessoryMAView maProfileWithModel:kLineModel];
    }
    if (self.targetLineStatus == Y_StockChartTargetLineStatusMA) {
        [self.kLineMAView maProfileWithModel:kLineModel];
    }
    if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
        [self.kBollMAView maProfileWithModel:kLineModel];
    }
}

#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    static BOOL isNeedPostNotification = YES;
    //    if(scrollView.contentOffset.x < scrollView.frame.size.width * 2)
    //    {
    //        if(isNeedPostNotification)
    //        {
    //            self.oldExactOffset = scrollView.contentSize.width - scrollView.contentOffset.x;
    //            isNeedPostNotification = NO;
    //        }
    //    } else {
    //        isNeedPostNotification = YES;
    //    }
//     [self setNeedsDisplay];
//    static CGFloat oldPositionX = 0;
    
//    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
//        CGFloat minDistance = [Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap];
////        if (ABS(oldPositionX - scrollView.contentOffset.x) <= minDistance / 2) {
////            self.scrollView.scrollEnabled = false;
////        }
//        if(ABS(oldPositionX - scrollView.contentOffset.x) < minDistance && ABS(oldPositionX - scrollView.contentOffset.x) > minDistance / 2 )
//        {
////            self.scrollView.scrollEnabled = YES;
//            [scrollView setContentOffset:CGPointMake(oldPositionX - scrollView.contentOffset.x > 0 ? oldPositionX - ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]) : oldPositionX +([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]), 0)];
//        }
//
//    }
    //
//    oldPositionX = scrollView.contentOffset.x;
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//}
//}

- (void)dealloc{
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
