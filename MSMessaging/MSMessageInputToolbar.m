//
//  MSMessageInputToolbar.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MSMessageInputToolbar.h"

@interface MSMessageInputToolbar () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *messageInputTextView;
@property (nonatomic, strong) UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPaddingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomPaddingConstraint;
@property (nonatomic, strong) MSMessageInputViewModel *viewModel;

- (void)sendButtonPressed:(id)sender;

- (void)commonInit;
- (void)addMessageInputTextView;
- (void)addSendButton;

@end

@implementation MSMessageInputToolbar

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
	[self.messageInputTextView layoutIfNeeded];
	CGFloat height = MAX(28, self.messageInputTextView.contentSize.height + self.messageInputTextView.textContainerInset.top + self.messageInputTextView.textContainerInset.bottom);
	if (self.viewModel) {
		height += self.viewModel.layoutSpec.messageInputTextViewPadding.top + self.viewModel.layoutSpec.messageInputTextViewPadding.bottom;
	}
	
	return CGSizeMake(0.f, height);
}

- (void)setViewModel:(MSMessageInputViewModel *)viewModel
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
		self.viewModel.inputTextViewName : self.messageInputTextView,
		self.viewModel.sendButtonName : self.sendButton,
	};
	
	for (NSString *layoutConstraint in self.viewModel.layoutConstraints) {
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutConstraint options:0 metrics:nil views:views]];
	}

	[self setNeedsUpdateConstraints];
}

- (void)scrollToCaret
{
	[UIView animateWithDuration:0.1f animations:^{
		CGRect rect = [self.messageInputTextView caretRectForPosition:self.messageInputTextView.selectedTextRange.start];
		rect.size.height += self.messageInputTextView.textContainerInset.bottom;
		[self.messageInputTextView scrollRectToVisible:rect animated:NO];
		[self invalidateIntrinsicContentSize];
		[self layoutIfNeeded];
	}];
}

- (void)clearInputText
{
	self.messageInputTextView.text = @"";
	if ([self.delegate respondsToSelector:@selector(messageInputToolbarDidChangeText:)]) {
		[self.delegate messageInputToolbarDidChangeText:self];
	}
}

- (void)sendButtonPressed:(id)sender
{
	if ([self.delegate respondsToSelector:@selector(messageInputToolbar:didSendMessageText:)]) {
		[self.delegate messageInputToolbar:self didSendMessageText:self.messageInputTextView.text];
	}
}

- (void)commonInit
{
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self addMessageInputTextView];
	[self addSendButton];
}

- (void)addMessageInputTextView
{
	self.messageInputTextView = [[UITextView alloc] init];
	self.messageInputTextView.translatesAutoresizingMaskIntoConstraints = NO;
	self.messageInputTextView.delegate = self;
	[self addSubview:self.messageInputTextView];
}

- (void)addSendButton
{
	self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
	self.sendButton.translatesAutoresizingMaskIntoConstraints = NO;
	self.sendButton.userInteractionEnabled = YES;
	[self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
	[self.sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:self.sendButton];
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
	if ([self.delegate respondsToSelector:@selector(messageInputToolbarDidChangeText:)]) {
		[self.delegate messageInputToolbarDidChangeText:self];
	}
}

@end
