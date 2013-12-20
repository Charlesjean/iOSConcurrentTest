//
//  ColorLabel.m
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import "ColorLabel.h"

@implementation ColorLabel

@synthesize progress = _progress;
@synthesize fillColor = _fillColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _progress = 1;
        _fillColor = [UIColor redColor];
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(context, CGColorGetComponents(self.fillColor.CGColor));
    CGRect rectTmp;
    rectTmp.origin = rect.origin;
    rectTmp.size.height = rect.size.height;
    rectTmp.size.width = rect.size.width/ 100.0 * self.progress;
    CGContextFillRect(context, rectTmp);
}


@end
