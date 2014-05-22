//
//  MessageBubbleController.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleController.h"

@implementation MessageBubbleController

- (MessageBubbleViewModel *)viewModelForSentMessage:(NSString *)sentMessage;
{
	MessageBubbleLayoutSpec *layoutSpec = [[MessageBubbleLayoutSpec alloc] init];
	layoutSpec.collectionViewSize = self.collectionViewSize;
	layoutSpec.bubbleMaskImageSize = CGSizeMake(48.f, 35.f);
	layoutSpec.bubbleMaskOffset = CGPointMake(20.f, 16.f);
	layoutSpec.messageBubbleInsets = UIEdgeInsetsMake(0.f, 74.f, 0.f, 10.f);
	layoutSpec.messageLabelInsets = UIEdgeInsetsMake(6.5f, 12.f, 7.5f, 18.f);
	
	CGFloat constraintWidth = self.collectionViewSize.width - (layoutSpec.messageBubbleInsets.left + layoutSpec.messageBubbleInsets.right + layoutSpec.messageLabelInsets.left + layoutSpec.messageLabelInsets.right);
	CGSize constraintSize = CGSizeMake(constraintWidth, MAXFLOAT);
	layoutSpec.messageLabelSize = [sentMessage boundingRectWithSize:constraintSize
																			  options:NSStringDrawingUsesLineFragmentOrigin
																		  attributes:@{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody] }
																			  context:nil].size;

	return [[MessageBubbleViewModel alloc] initWithMessageLabelText:sentMessage layoutSpec:layoutSpec];
}

@end
