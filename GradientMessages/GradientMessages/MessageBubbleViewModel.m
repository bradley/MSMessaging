//
//  MessageBubbleViewModel.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleViewModel.h"

@interface MessageBubbleViewModel ()

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGRect messageFrame;
@property (nonatomic, assign) CGRect gradientFrame;
@property (nonatomic, assign) CGRect bubbleMaskFrame;

@property (nonatomic, assign) UIEdgeInsets bubbleInsets;
@property (nonatomic, assign) UIEdgeInsets textInsets;
@property (nonatomic, assign) CGFloat gradientHeight;
@property (nonatomic, assign) CGFloat viewWidth;

- (void)calculateFrames;
- (CGRect)bubbleMaskFrameForMessageSize:(CGSize)messageSize;
- (CGRect)messageFrameForMessageSize:(CGSize)messageSize bubbleMaskFrame:(CGRect)bubbleMaskFrame;
- (CGRect)gradientFrameForBubbleMaskFrame:(CGRect)bubbleMaskFrame;

@end

@implementation MessageBubbleViewModel

- (instancetype)initWithMessageText:(NSString *)messageText viewWidth:(CGFloat)viewWidth gradientHeight:(CGFloat)gradientHeight
{
	self = [super init];
	if (self) {
		self.messageText = messageText;
		self.viewWidth = viewWidth;
		self.gradientHeight = gradientHeight;
		self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		
		self.bubbleInsets = UIEdgeInsetsMake(0.f, 74.f, 0.f, 10.f);
		self.textInsets = UIEdgeInsetsMake(6.5f, 12.f, 7.5f, 18.f);
		
		[self calculateFrames];
	}
	
	return self;
}

- (void)calculateFrames
{
	CGFloat constraintWidth = self.viewWidth - (self.bubbleInsets.left + self.bubbleInsets.right + self.textInsets.left + self.textInsets.right);
	CGSize constraintSize = CGSizeMake(constraintWidth, MAXFLOAT);
	CGSize messageSize = [self.messageText boundingRectWithSize:constraintSize
																		 options:NSStringDrawingUsesLineFragmentOrigin
																	 attributes:@{ NSFontAttributeName : self.font }
																		 context:nil].size;
	
	self.bubbleMaskFrame = [self bubbleMaskFrameForMessageSize:messageSize];
	self.messageFrame = [self messageFrameForMessageSize:messageSize bubbleMaskFrame:self.bubbleMaskFrame];
	self.gradientFrame = [self gradientFrameForBubbleMaskFrame:self.bubbleMaskFrame];
	self.cellSize = CGSizeMake(self.viewWidth, self.bubbleMaskFrame.size.height);
}

- (CGRect)bubbleMaskFrameForMessageSize:(CGSize)messageSize
{
	const float imageWidth = 48.f;
	const float imageHeight = 35.f;
	
	CGFloat width = MAX(ceil(messageSize.width + self.textInsets.left + self.textInsets.right), imageWidth);
	CGFloat height = MAX(ceil(messageSize.height + self.textInsets.top + self.textInsets.bottom), imageHeight);
	CGFloat maxBubbleWidth = self.viewWidth - (self.bubbleInsets.left + self.bubbleInsets.right);
	
	CGFloat x = self.bubbleInsets.left + (maxBubbleWidth - width);
	CGFloat y = self.bubbleInsets.top;
	
	return CGRectMake(x, y, width, height);
}

- (CGRect)messageFrameForMessageSize:(CGSize)messageSize bubbleMaskFrame:(CGRect)bubbleMaskFrame
{
	CGFloat bubbleOffset = self.textInsets.right - self.textInsets.left;
	CGFloat halfBubbleWidth = (bubbleMaskFrame.size.width - bubbleOffset) * 0.5f;
	CGFloat halfMessageWidth = messageSize.width * 0.5f;
	
	CGFloat x = bubbleMaskFrame.origin.x + floor(halfBubbleWidth - halfMessageWidth);
	CGFloat y = bubbleMaskFrame.origin.y + self.textInsets.top;
	
	return CGRectMake(x, y, messageSize.width, messageSize.height);
}

- (CGRect)gradientFrameForBubbleMaskFrame:(CGRect)bubbleMaskFrame
{
	return CGRectMake(bubbleMaskFrame.origin.x, bubbleMaskFrame.origin.y, bubbleMaskFrame.size.width, self.gradientHeight);
}

@end
