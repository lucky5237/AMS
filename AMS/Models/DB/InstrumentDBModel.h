//
//  InstrumentDBModel.h
//  AMS
//
//  Created by jianlu on 2018/12/22.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <BGFMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface InstrumentDBModel : NSObject
@property(nonatomic,copy) NSString *instrumentID;//合约代码
@property(nonatomic,copy) NSString *exchangeID;//交易所代码
@property(nonatomic,copy) NSString *instrumentName;//合约名称
@property(nonatomic,strong) NSNumber *volumeMultiple;//合约数量乘数
@property(nonatomic,copy) NSString *priceTick;//最小变动价
//@property(nonatomic,copy) NSString *ShortMarginRatio;//空头保证金率
//@property(nonatomic,copy) NSString *LongMarginRatio;//多头保证金率
@property(nonatomic,strong) NSNumber *hasCollect;//是否已经收藏 0-no 1-yes÷

@end

NS_ASSUME_NONNULL_END
