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
@property (nonatomic, strong) UIColor *messageLabelColor;
@property (nonatomic, strong) UIColor *messageBackgroundColor;
@property (nonatomic, assign) CATransform3D bubbleMaskTransform;
@property (nonatomic, strong) MessageBubbleLayoutSpec *layoutSpec;

@end

@implementation MessageBubbleViewModel

- (instancetype)initWithMessageLabelText:(NSString *)messageLabelText isAuthor:(BOOL)isAuthor layoutSpec:(MessageBubbleLayoutSpec *)layoutSpec
{
	self = [super init];
	if (self) {
		self.messageLabelText = messageLabelText;
		self.messageLabelColor = isAuthor ? [UIColor whiteColor] : [UIColor blackColor];
		self.messageBackgroundColor = isAuthor ? nil : [UIColor colorWithRed:229.f/255.f green:229.f/255.f blue:234.f/255.f alpha:1.f];
		self.bubbleMaskTransform = isAuthor ? CATransform3DIdentity : CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f);
		self.layoutSpec = layoutSpec;
	}
	
	return self;
}

@end
