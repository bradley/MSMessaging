//
//  MessageBubbleLayoutSpec.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleLayoutSpec.h"

@implementation MessageBubbleLayoutSpec

- (CGRect)bubbleMaskLayerContentsCenter
{
	return CGRectMake(self.bubbleMaskOffset.x/self.bubbleMaskImageSize.width, self.bubbleMaskOffset.y/self.bubbleMaskImageSize.height, 0.f, 0.f);
}

- (CGSize)cellSize
{
	CGFloat height = MAX(ceil(self.messageLabelSize.height + self.messageLabelInsets.top + self.messageLabelInsets.bottom), self.bubbleMaskImageSize.height);
	return CGSizeMake(self.collectionViewSize.width, height);
}

- (CGRect)bubbleMaskFrame
{
	CGFloat maxBubbleWidth = self.collectionViewSize.width - (self.messageBubbleInsets.left + self.messageBubbleInsets.right);
	CGFloat width = MAX(ceil(self.messageLabelSize.width + self.messageLabelInsets.left + self.messageLabelInsets.right), self.bubbleMaskImageSize.width);
	CGFloat height = MAX(ceil(self.messageLabelSize.height + self.messageLabelInsets.top + self.messageLabelInsets.bottom), self.bubbleMaskImageSize.height);
	CGFloat x = self.messageBubbleInsets.left;
	CGFloat y = self.messageBubbleInsets.top;

	if (self.alignMessageLabelRight) {
		x += (maxBubbleWidth - width);
	}
	
	return CGRectMake(x, y, width, height);
}

- (CGRect)messageLabelFrame
{
	CGFloat x = self.messageBubbleInsets.left + self.messageLabelInsets.left;
	CGFloat y = self.messageBubbleInsets.top + self.messageLabelInsets.top;
	
	if (self.alignMessageLabelRight) {
		x += self.collectionViewSize.width - x - self.messageLabelSize.width - self.messageLabelInsets.right - self.messageBubbleInsets.right;
	}
	
	return CGRectMake(ceil(x), ceil(y), ceil(self.messageLabelSize.width), ceil(self.messageLabelSize.height));
}

- (CGRect)gradientFrame
{
	CGFloat maxBubbleWidth = self.collectionViewSize.width - (self.messageBubbleInsets.left + self.messageBubbleInsets.right);
	CGFloat width = MAX(ceil(self.messageLabelSize.width + self.messageLabelInsets.left + self.messageLabelInsets.right), self.bubbleMaskImageSize.width);
	CGFloat x = self.messageBubbleInsets.left;
	CGFloat y = self.messageBubbleInsets.top + self.messageLabelInsets.top + (self.messageLabelSize.height * 0.5f);
	
	if (self.alignMessageLabelRight) {
		x += (maxBubbleWidth - width);
	}
		
	return CGRectMake(ceil(x), ceil(y), width, self.collectionViewSize.height);
}

@end
