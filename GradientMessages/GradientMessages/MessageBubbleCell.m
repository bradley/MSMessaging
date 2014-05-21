//
//  MessageBubbleCell.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleCell.h"
#import "MessageBubbleViewModel.h"

@interface MessageBubbleCell ()

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, strong) CALayer *bubbleMaskLayer;

- (void)commonInit;

@end

@implementation MessageBubbleCell

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

- (void)setViewModel:(MessageBubbleViewModel *)viewModel
{
	_viewModel = viewModel;
	
	self.messageLabel.text = viewModel.messageText;
	self.messageLabel.frame = viewModel.messageFrame;
	self.gradientLayer.frame = viewModel.gradientFrame;
	self.bubbleMaskLayer.frame = viewModel.bubbleMaskFrame;
}

- (void)setGradientOffset:(CGFloat)gradientOffset
{
	_gradientOffset = gradientOffset;
	self.gradientLayer.position = CGPointMake(self.gradientLayer.position.x, -gradientOffset);
}

- (void)commonInit
{
	const CGFloat imageWidth = 48.f;
	const CGFloat imageHeight = 35.f;
	const CGFloat minX = 20.f;
	const CGFloat minY = 16.f;
	
	NSDictionary *nullImplicitAnims = @{
		@"position" : [NSNull null],
		@"bounds" : [NSNull null],
	};
	
	self.gradientLayer = [CALayer layer];
	self.gradientLayer.actions = nullImplicitAnims;
	self.gradientLayer.anchorPoint = CGPointZero;
	self.gradientLayer.contentsScale = [UIScreen mainScreen].scale;
	self.gradientLayer.contents = (id)[UIImage imageNamed:@"BlueGradient"].CGImage;
	[self.layer addSublayer:self.gradientLayer];
	
	self.bubbleMaskLayer = [CALayer layer];
	self.bubbleMaskLayer.actions = nullImplicitAnims;
	self.bubbleMaskLayer.anchorPoint = CGPointZero;
	self.bubbleMaskLayer.contentsScale = [UIScreen mainScreen].scale;
	self.bubbleMaskLayer.contents = (id)[UIImage imageNamed:@"MessageBubble"].CGImage;
	self.bubbleMaskLayer.contentsCenter = CGRectMake(minX/imageWidth, minY/imageHeight, 0.f, 0.f);
	[self.layer addSublayer:self.bubbleMaskLayer];
	
	self.messageLabel = [[UILabel alloc] init];
	self.messageLabel.numberOfLines = 0;
	self.messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	self.messageLabel.textColor = [UIColor whiteColor];
	[self addSubview:self.messageLabel];
}

@end
