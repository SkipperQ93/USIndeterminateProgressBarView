//
//  USIndeterminateProgressBarView.m
//  UNation-iOS
//
//  Created by Usama Abdul Aziz on 09/09/2016.
//  Copyright © 2016 UNation. All rights reserved.
//

#import "USIndeterminateProgressBarView.h"
#import "HexColor.h"

@interface USIndeterminateProgressBarView() {
    CGFloat speed, chunkWidth;
}

@property CGFloat numberOfBars, marginWidth, timeTakenByOneBarToCoverScreen;
@property UIColor *barColor;

@end

@implementation USIndeterminateProgressBarView

- (id)initWithFrame:(CGRect)frame numberOfBars:(CGFloat)numberOfBars marginWidth:(CGFloat)marginWidth timeTakenByOneBarToCoverScreen:(CGFloat)timeTakenByOneBarToCoverScreen barColor:(UIColor*)color backgroundColor:(UIColor*)bgColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = bgColor;
        
        _numberOfBars = numberOfBars;
        _marginWidth = marginWidth;
        _timeTakenByOneBarToCoverScreen = timeTakenByOneBarToCoverScreen;
        _barColor = color;
        
        chunkWidth = (self.frame.size.width/numberOfBars)-marginWidth;
        speed = (chunkWidth + marginWidth + self.frame.size.width)/timeTakenByOneBarToCoverScreen;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAnimating)    name:@"ApplicationInBackground" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimating)   name:@"ApplicationInForeground" object:nil];
        
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ApplicationInBackground" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ApplicationInForeground" object:nil];
}

- (void)startAnimating {
    self.progressChunks = [@[] mutableCopy];
    CGFloat xPoint = 0;
    for (int i=0; i<(_numberOfBars+10); i++) {
        UIView *chunk = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - chunkWidth - xPoint, 0, chunkWidth, self.frame.size.height)];
        chunk.backgroundColor = _barColor;
        [self addSubview:chunk];
        [self.progressChunks addObject:chunk];
        xPoint += (_marginWidth+chunkWidth);
    }
    for (UIView *chunk in self.progressChunks) {
        [self animateProgressChunk:chunk];
    }
}

- (void)stopAnimating {
    for (UIView *v in self.progressChunks) {
        [v setHidden:YES];
        [v removeFromSuperview];
    }
    self.progressChunks = nil;
}

-(CGFloat) getTimeForDistance:(CGFloat)distance {
    CGFloat time = distance/speed;
    return time;
}

- (void)animateProgressChunk:(UIView *)chunk {
    if (self && !chunk.isHidden) {
        [UIView animateWithDuration:[self getTimeForDistance:(self.frame.size.width-chunk.frame.origin.x)] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect chuckFrame = chunk.frame;
            chuckFrame.origin.x = self.frame.size.width;
            chunk.frame = chuckFrame;
        } completion:^(BOOL finished) {
            CGRect chuckFrame = chunk.frame;
            int chunkIndex = (int)[self.progressChunks indexOfObject:chunk];
            UIView *previousChunk;
            if (chunkIndex == 0) {
                previousChunk = [self.progressChunks objectAtIndex:(self.progressChunks.count-1)];
            }
            else {
                previousChunk = [self.progressChunks objectAtIndex:(chunkIndex-1)];
            }
            chuckFrame.origin.x = [previousChunk.layer.presentationLayer frame].origin.x - _marginWidth - chunkWidth;
            chunk.frame = chuckFrame;
            [self animateProgressChunk:chunk];
        }];
    }
}

@end
