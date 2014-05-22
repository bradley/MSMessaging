//
//  MessageBubbleViewModel.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

#import "MessageBubbleLayoutSpec.h"

@interface MessageBubbleViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *messageLabelText;
@property (nonatomic, strong, readonly) UIColor *messageLabelColor;
@property (nonatomic, strong, readonly) UIColor *messageBackgroundColor;
@property (nonatomic, assign, readonly) CATransform3D bubbleMaskTransform;
@property (nonatomic, strong, readonly) MessageBubbleLayoutSpec *layoutSpec;

- (instancetype)initWithMessageLabelText:(NSString *)messageLabelText isAuthor:(BOOL)isAuthor layoutSpec:(MessageBubbleLayoutSpec *)layoutSpec;

@end
