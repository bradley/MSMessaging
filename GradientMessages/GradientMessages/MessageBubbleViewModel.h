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
@property (nonatomic, strong, readonly) MessageBubbleLayoutSpec *layoutSpec;

- (instancetype)initWithMessageLabelText:(NSString *)messageLabelText layoutSpec:(MessageBubbleLayoutSpec *)layoutSpec;

@end
