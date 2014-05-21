//
//  MessageBubbleViewModel.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@interface MessageBubbleViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *messageText;
@property (nonatomic, strong, readonly) UIFont *font;
@property (nonatomic, assign, readonly) CGSize cellSize;
@property (nonatomic, assign, readonly) CGRect messageFrame;
@property (nonatomic, assign, readonly) CGRect gradientFrame;
@property (nonatomic, assign, readonly) CGRect bubbleMaskFrame;

- (instancetype)initWithMessageText:(NSString *)messageText viewWidth:(CGFloat)viewWidth gradientHeight:(CGFloat)gradientHeight;

@end
