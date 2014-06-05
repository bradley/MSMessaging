//
//  MSMessageBubbleViewModel.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MSMessageBubbleViewModel.h"

@interface MSMessageBubbleViewModel ()

@property (nonatomic, assign) CGSize containerSize;
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGRect bubbleMaskFrame;
@property (nonatomic, assign) CGRect messageLabelFrame;
@property (nonatomic, assign) CGRect gradientFrame;
@property (nonatomic, assign) CGRect bubbleMaskLayerContentsCenter;

@property (nonatomic, copy) NSString *messageLabelText;
@property (nonatomic, strong) UIColor *messageLabelColor;
@property (nonatomic, strong) UIColor *messageBackgroundColor;
@property (nonatomic, assign) CATransform3D bubbleMaskTransform;

// TODO-mstultz: Move this into initialization
@property (nonatomic, assign) CGPoint bubbleMaskOffset;
@property (nonatomic, assign) CGSize bubbleMaskImageSize;
@property (nonatomic, assign) UIEdgeInsets messageBubbleContentInset;
@property (nonatomic, assign) UIEdgeInsets messageLabelInsets;
@property (nonatomic, assign) CGSize messageLabelSize;

@end

@implementation MSMessageBubbleViewModel

- (instancetype)initWithContainerSize:(CGSize)containerSize messageText:(NSString *)messageText isAuthor:(BOOL)isAuthor
{
	self = [super init];
	if (self) {		
		self.messageLabelText = messageText;
		self.messageLabelColor = isAuthor ? [UIColor whiteColor] : [UIColor blackColor];
		self.messageBackgroundColor = isAuthor ? nil : [UIColor colorWithRed:229.f/255.f green:229.f/255.f blue:234.f/255.f alpha:1.f];
		self.bubbleMaskTransform = isAuthor ? CATransform3DIdentity : CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f);
		
		self.bubbleMaskOffset = CGPointMake(20.f, 16.f);
		self.bubbleMaskImageSize = CGSizeMake(48.f, 35.f);
		self.messageBubbleContentInset = ( isAuthor ) ? UIEdgeInsetsMake(0.f, 74.f, 0.f, 10.f) : UIEdgeInsetsMake(0.f, 10.f, 0.f, 74.f);
		self.messageLabelInsets = ( isAuthor ) ? UIEdgeInsetsMake(6.5f, 12.f, 7.5f, 18.f) : UIEdgeInsetsMake(6.5f, 18.f, 7.5f, 12.f);
		
		CGFloat viewWidth = containerSize.width;
		CGFloat constraintWidth = viewWidth - (self.messageBubbleContentInset.left + self.messageBubbleContentInset.right + self.messageLabelInsets.left + self.messageLabelInsets.right);
		CGSize constraintSize = CGSizeMake(constraintWidth, MAXFLOAT);
		self.messageLabelSize = [messageText boundingRectWithSize:constraintSize
																		  options:NSStringDrawingUsesLineFragmentOrigin
																	  attributes:@{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody] }
																		  context:nil].size;

		CGFloat viewHeight = MAX(ceil(self.messageLabelSize.height + self.messageLabelInsets.top + self.messageLabelInsets.bottom), self.bubbleMaskImageSize.height);
		CGFloat maxBubbleWidth = viewWidth - (self.messageBubbleContentInset.left + self.messageBubbleContentInset.right);
		CGFloat bubbleWidth = MAX(ceil(self.messageLabelSize.width + self.messageLabelInsets.left + self.messageLabelInsets.right), self.bubbleMaskImageSize.width);
		CGFloat bubbleMaskOriginX = self.messageBubbleContentInset.left;
		CGFloat messageLabelX = self.messageBubbleContentInset.left + self.messageLabelInsets.left;
		CGFloat messageLabelY = self.messageBubbleContentInset.top + self.messageLabelInsets.top;
		CGFloat gradientX = self.messageBubbleContentInset.left;
		CGFloat gradientY = self.messageBubbleContentInset.top + self.messageLabelInsets.top + (self.messageLabelSize.height * 0.5f);
		
		if (isAuthor) {
			bubbleMaskOriginX += (maxBubbleWidth - bubbleWidth);
			messageLabelX = viewWidth - self.messageLabelSize.width - self.messageLabelInsets.right - self.messageBubbleContentInset.right;
			gradientX += (maxBubbleWidth - bubbleWidth);
		}
		
		self.cellSize = CGSizeMake(viewWidth, viewHeight);
		self.bubbleMaskFrame = CGRectMake(bubbleMaskOriginX, self.messageBubbleContentInset.top, bubbleWidth, viewHeight);
		self.messageLabelFrame = CGRectMake(ceil(messageLabelX), ceil(messageLabelY), ceil(self.messageLabelSize.width), ceil(self.messageLabelSize.height));
		self.gradientFrame = CGRectMake(ceil(gradientX), ceil(gradientY), bubbleWidth, containerSize.height);
		self.bubbleMaskLayerContentsCenter = CGRectMake(self.bubbleMaskOffset.x/self.bubbleMaskImageSize.width, self.bubbleMaskOffset.y/self.bubbleMaskImageSize.height, 0.f, 0.f);
	}
	
	return self;
}

@end
