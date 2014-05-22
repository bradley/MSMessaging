//
//  MessageBubbleViewModel.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleViewModel.h"

@interface MessageBubbleViewModel ()

@property (nonatomic, copy) NSString *messageLabelText;
@property (nonatomic, strong) MessageBubbleLayoutSpec *layoutSpec;

@end

@implementation MessageBubbleViewModel

- (instancetype)initWithMessageLabelText:(NSString *)messageLabelText layoutSpec:(MessageBubbleLayoutSpec *)layoutSpec
{
	self = [super init];
	if (self) {
		self.messageLabelText = messageLabelText;
		self.layoutSpec = layoutSpec;
	}
	
	return self;
}

@end
