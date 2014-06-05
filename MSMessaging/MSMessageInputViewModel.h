//
//  MSMessageInputViewModel.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

#import "MSMessageInputLayoutSpec.h"

@interface MSMessageInputViewModel : NSObject

@property (nonatomic, strong, readonly) MSMessageInputLayoutSpec *layoutSpec;
@property (nonatomic, assign) CGFloat messageTextViewCornerRadius;
@property (nonatomic, assign) CGFloat messageTextViewBorderWidth;
@property (nonatomic, strong) UIColor *messageTextViewBackgroundColor;
@property (nonatomic, strong) UIColor *messageTextViewBorderColor;
@property (nonatomic, strong) UIColor *messageTextViewFontColor;
@property (nonatomic, strong) UIFont *messageTextViewFont;
@property (nonatomic, strong) UIFont *sendButtonFont;

- (instancetype)initWithLayoutSpec:(MSMessageInputLayoutSpec *)layoutSpec;

@end
