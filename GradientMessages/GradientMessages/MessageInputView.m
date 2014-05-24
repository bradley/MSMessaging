//
//  MessageInputView.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageInputView.h"

@interface MessageInputView ()

@property (nonatomic, strong) UIToolbar *backgroundToolbar;
@property (nonatomic, strong) UITextView *messageInputTextView;
@property (nonatomic, strong) UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPaddingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomPaddingConstraint;
@property (nonatomic, strong) MessageInputViewModel *viewModel;

- (void)commonInit;
- (void)addBackgroundToolbar;
- (void)addMessageInputTextView;
- (void)addSendButton;

@end

@implementation MessageInputView

- (id)init
{
	return [super init];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if(self) {
		[self commonInit];
	}
	return self;
}

- (CGSize)intrinsicContentSize
{
	CGFloat height = self.inputTextView.contentSize.height;
	if (self.viewModel) {
		height += self.viewModel.layoutSpec.messageInputTextViewPadding.top + self.viewModel.layoutSpec.messageInputTextViewPadding.bottom;
	}
	
	return CGSizeMake(0.f, height);
}

- (void)setViewModel:(MessageInputViewModel *)viewModel
{
	_viewModel = viewModel;
	
	self.messageInputTextView.textContainerInset = viewModel.layoutSpec.messageInputTextViewContentInset;
	self.messageInputTextView.layer.cornerRadius = viewModel.messageInputCornerRadius;
	self.messageInputTextView.layer.borderWidth = viewModel.messageInputBorderWidth;
	self.messageInputTextView.backgroundColor = viewModel.messageInputBackgroundColor;
	self.messageInputTextView.font = viewModel.messageInputFont;
	self.messageInputTextView.textColor = viewModel.messageInputFontColor;
	self.messageInputTextView.layer.borderColor = viewModel.messageInputBorderColor.CGColor;
	self.sendButton.titleLabel.font = viewModel.sendButtonFont;

	NSDictionary *views = @{
		self.viewModel.backgroundToolbarName : self.backgroundToolbar,
		self.viewModel.inputTextViewName : self.inputTextView,
		self.viewModel.sendButtonName : self.sendButton,
	};
	
	for (NSString *layoutConstraint in self.viewModel.layoutConstraints) {
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutConstraint options:0 metrics:nil views:views]];
	}
	
	[self setNeedsUpdateConstraints];
}

- (void)scrollToCaret
{
	CGRect rect = [self.inputTextView caretRectForPosition:self.inputTextView.selectedTextRange.start];
	rect.size.height += self.inputTextView.textContainerInset.bottom;
	[self.inputTextView scrollRectToVisible:rect animated:NO];
}

- (void)commonInit
{
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self addBackgroundToolbar];
	[self addMessageInputTextView];
	[self addSendButton];
}

- (void)addBackgroundToolbar
{
	self.backgroundToolbar = [[UIToolbar alloc] init];
	self.backgroundToolbar.translatesAutoresizingMaskIntoConstraints = NO;
	self.backgroundToolbar.barStyle = UIBarStyleDefault;
	[self addSubview:self.backgroundToolbar];
}

- (void)addMessageInputTextView
{
	self.messageInputTextView = [[UITextView alloc] init];
	self.messageInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.messageInputTextView];
}

- (void)addSendButton
{
	self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
	self.sendButton.translatesAutoresizingMaskIntoConstraints = NO;
	self.sendButton.userInteractionEnabled = YES;
	[self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
	[self addSubview:self.sendButton];
}

@end
