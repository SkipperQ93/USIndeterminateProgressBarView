//
//  USIndeterminateProgressBarView.h
//  UNation-iOS
//
//  Created by Usama Abdul Aziz on 09/09/2016.
//  Copyright © 2016 UNation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USIndeterminateProgressBarView : UIView

@property (nonatomic, strong) NSMutableArray * progressChunks;

- (void)startAnimating;
- (void)stopAnimating;

- (id)initWithFrame:(CGRect)frame numberOfBars:(CGFloat)numberOfBars marginWidth:(CGFloat)marginWidth timeTakenByOneBarToCoverScreen:(CGFloat)timeTakenByOneBarToCoverScreen barColor:(UIColor*)color backgroundColor:(UIColor*)bgColor;

@end
