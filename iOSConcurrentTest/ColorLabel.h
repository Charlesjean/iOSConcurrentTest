//
//  ColorLabel.h
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorLabel : UILabel

@property(nonatomic,assign)int progress;
@property(nonatomic,strong)UIColor* fillColor;
@end
