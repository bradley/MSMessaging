//
//  MSMessageInputToolbar.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MSMessageInputToolbar.h"

@interface MSMessageInputToolbar () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPaddingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomPaddingConstraint;
@property (nonatomic, strong) MSMessageInputViewModel *viewModel;

- (void)sendButtonPressed:(id)sender;

- (void)commonInit;
- (void)addMessageTextView;
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
	[self.messageTextView layoutIfNeeded];
	
	CGFloat height = self.messageTextView.contentSize.height;
	if (self.viewModel) {
		height += self.viewModel.layoutSpec.contentInset.top + self.viewModel.layoutSpec.contentInset.bottom;
	}

	return CGSizeMake(0.f, height);
}

- (void)setViewModel:(MSMessageInputViewModel *)viewModel
{
	_viewModel = viewModel;
	
	self.messageTextView.textContainerInset = viewModel.layoutSpec.messageTextViewContentInset;
	self.messageTextView.layer.cornerRadius = viewModel.messageTextViewCornerRadius;
	self.messageTextView.layer.borderWidth = viewModel.messageTextViewBorderWidth;
	self.messageTextView.backgroundColor = viewModel.messageTextViewBackgroundColor;
	self.messageTextView.font = viewModel.messageTextViewFont;
	self.messageTextView.textColor = viewModel.messageTextViewFontColor;
	self.messageTextView.layer.borderColor = viewModel.messageTextViewBorderColor.CGColor;
	self.sendButton.contentEdgeInsets = viewModel.layoutSpec.sendButtonContentEdgeInsets;
	self.sendButton.titleLabel.font = viewModel.sendButtonFont;

	NSDictionary *views = @{
		@"messageTextView" : self.messageTextView,
		@"sendButton" : self.sendButton,
	};

	const CGFloat leftPadding = viewModel.layoutSpec.contentInset.left;
	const CGFloat rightPadding = viewModel.layoutSpec.contentInset.right;
	const CGFloat topPadding = viewModel.layoutSpec.contentInset.top;
	const CGFloat bottomPadding = viewModel.layoutSpec.contentInset.bottom;
	
	NSArray *visualConstraints = @[
		[NSString stringWithFormat:@"H:|-%.2f-[messageTextView]-%.2f-[sendButton]-%.2f-|", leftPadding, rightPadding, rightPadding],
		[NSString stringWithFormat:@"V:|-%.2f-[messageTextView]-%.2f-|", topPadding, bottomPadding],
		[NSString stringWithFormat:@"V:[sendButton]-%.2f-|", bottomPadding],
	];
	
	for (NSString *visualConstraint in visualConstraints) {
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualConstraint options:0 metrics:nil views:views]];
	}
	
	[self setNeedsUpdateConstraints];
}

- (void)scrollToCaret
{
	[UIView animateWithDuration:0.1f animations:^{
		CGRect rect = [self.messageTextView caretRectForPosition:self.messageTextView.selectedTextRange.start];
		rect.size.height += self.messageTextView.textContainerInset.bottom;
		[self.messageTextView scrollRectToVisible:rect animated:NO];
		[self invalidateIntrinsicContentSize];
		[self layoutIfNeeded];
	}];
}

- (void)clearInputText
{
	self.messageTextView.text = @"";
	if ([self.delegate respondsToSelector:@selector(messageInputToolbarDidChangeText:)]) {
		[self.delegate messageInputToolbarDidChangeText:self];
	}
}

- (void)sendButtonPressed:(id)sender
{
	if ([self.delegate respondsToSelector:@selector(messageInputToolbar:didSendMessageText:)]) {
		[self.delegate messageInputToolbar:self didSendMessageText:self.messageTextView.text];
	}

	self.messageTextView.text = @"";
	[self.messageTextView endEditing:YES];
}

- (void)commonInit
{
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self addMessageTextView];
	[self addSendButton];
}

- (void)addMessageTextView
{
	self.messageTextView = [[UITextView alloc] init];
	self.messageTextView.translatesAutoresizingMaskIntoConstraints = NO;
	self.messageTextView.delegate = self;
	[self addSubview:self.messageTextView];
}

- (void)addSendButton
{
	self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
	self.sendButton.translatesAutoresizingMaskIntoConstraints = NO;
	self.sendButton.userInteractionEnabled = YES;
	[self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
	[self.sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.sendButton sizeToFit];
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
