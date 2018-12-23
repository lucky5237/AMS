//
//  InstumentModel.m
//  AMS
//
//  Created by jianlu on 2018/12/22.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "InstumentModel.h"


@implementation InstumentModel
-(instancetype)initWithInstumentDBModel:(InstrumentDBModel *)dbModel{
    if (self = [super init]) {
        User_Onrspqryinstrument *insturment = [[User_Onrspqryinstrument alloc] init];
        insturment.InstrumentID = dbModel.instrumentID;
        insturment.InstrumentName = dbModel.instrumentName;
        insturment.VolumeMultiple = dbModel.volumeMultiple;
        insturment.PriceTick = dbModel.priceTick;
        self.instrument = insturment;
    }
    return self;
}
@end
