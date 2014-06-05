//
//  MSMessageBubbleCell.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MSMessageBubbleCell.h"

@interface MSMessageBubbleCell ()

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, strong) CALayer *bubbleMaskLayer;

- (void)commonInit;

@end

@implementation MSMessageBubbleCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	
	return self;
}

- (void)setViewModel:(MSMessageBubbleViewModel *)viewModel
{
	_viewModel = viewModel;
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	
	if (viewModel.messageBackgroundColor) {
		[self.gradientLayer removeFromSuperlayer];
		self.bubbleMaskLayer.backgroundColor = viewModel.messageBackgroundColor.CGColor;
	}
	else {
		[self.layer insertSublayer:self.gradientLayer below:self.bubbleMaskLayer];
		self.bubbleMaskLayer.backgroundColor = nil;
	}
	
	self.messageLabel.text = viewModel.messageLabelText;
	self.messageLabel.textColor = viewModel.messageLabelColor;
	self.bubbleMaskLayer.contentsCenter = viewModel.bubbleMaskLayerContentsCenter;
	self.messageLabel.frame = viewModel.messageLabelFrame;
	self.gradientLayer.frame = viewModel.gradientFrame;
	self.bubbleMaskLayer.frame = viewModel.bubbleMaskFrame;
	self.bubbleMaskLayer.transform = viewModel.bubbleMaskTransform;

	[CATransaction commit];
}

- (void)setGradientOffset:(CGFloat)gradientOffset
{
	_gradientOffset = gradientOffset;
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

	self.gradientLayer.position = CGPointMake(self.gradientLayer.position.x, -gradientOffset);
	[CATransaction commit];
}

- (void)commonInit
{
	self.layer.masksToBounds = YES;
		
	self.gradientLayer = [CALayer layer];
	self.gradientLayer.anchorPoint = CGPointZero;
	self.gradientLayer.contentsScale = [UIScreen mainScreen].scale;
	self.gradientLayer.contents = (id)[UIImage imageNamed:@"BlueGradient"].CGImage;
	
	self.bubbleMaskLayer = [CALayer layer];
	self.bubbleMaskLayer.contentsScale = [UIScreen mainScreen].scale;
	self.bubbleMaskLayer.contents = (id)[UIImage imageNamed:@"MessageBubble"].CGImage;
	[self.layer addSublayer:self.bubbleMaskLayer];
	
	self.messageLabel = [[UILabel alloc] init];
	self.messageLabel.numberOfLines = 0;
	self.messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	[self addSubview:self.messageLabel];
}

@end
