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

@property (nonatomic, assign) CGFloat messageInputCornerRadius;
@property (nonatomic, assign) CGFloat messageInputBorderWidth;
@property (nonatomic, strong) UIColor *messageInputBackgroundColor;
@property (nonatomic, strong) UIColor *messageInputBorderColor;
@property (nonatomic, strong) UIFont *messageInputFont;
@property (nonatomic, strong) UIColor *messageInputFontColor;
@property (nonatomic, strong) UIFont *sendButtonFont;
@property (nonatomic, copy) NSString *backgroundToolbarName;
@property (nonatomic, copy) NSString *inputTextViewName;
@property (nonatomic, copy) NSString *sendButtonName;
@property (nonatomic, strong) NSArray *layoutConstraints;
@property (nonatomic, strong, readonly) MSMessageInputLayoutSpec *layoutSpec;

- (instancetype)initWithLayoutSpec:(MSMessageInputLayoutSpec *)layoutSpec;

@end
