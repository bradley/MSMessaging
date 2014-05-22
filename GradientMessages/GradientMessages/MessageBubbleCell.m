//
//  MessageBubbleCell.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageBubbleCell.h"

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
	
	self.bubbleMaskLayer.contentsCenter = [viewModel.layoutSpec bubbleMaskLayerContentsCenter];

	self.messageLabel.text = viewModel.messageLabelText;
	self.messageLabel.frame = [viewModel.layoutSpec messageLabelFrame];
	self.gradientLayer.frame = [viewModel.layoutSpec gradientFrame];
	self.bubbleMaskLayer.frame = [viewModel.layoutSpec bubbleMaskFrame];
}

- (void)setGradientOffset:(CGFloat)gradientOffset
{
	_gradientOffset = gradientOffset;
	self.gradientLayer.position = CGPointMake(self.gradientLayer.position.x, -gradientOffset);
}

- (void)commonInit
{
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
	[self.layer addSublayer:self.bubbleMaskLayer];
	
	self.messageLabel = [[UILabel alloc] init];
	self.messageLabel.numberOfLines = 0;
	self.messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	self.messageLabel.textColor = [UIColor whiteColor];
	[self addSubview:self.messageLabel];
}

@end
