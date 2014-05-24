//
//  MessageInputViewModel.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageInputViewModel.h"

@interface MessageInputViewModel ()

@property (nonatomic, strong) MessageInputLayoutSpec *layoutSpec;

@end

@implementation MessageInputViewModel

- (instancetype)initWithLayoutSpec:(MessageInputLayoutSpec *)layoutSpec
{
	self = [super init];
	if (self) {
		self.layoutSpec = layoutSpec;
	}
	
	return self;
}

+ (id)bullshit
{
	MessageInputLayoutSpec *layoutSpec = [[MessageInputLayoutSpec alloc] init];
	layoutSpec.messageInputTextViewContentInset = UIEdgeInsetsMake(5.f, 3.f, 0.f, 0.f);
	layoutSpec.messageInputTextViewPadding = UIEdgeInsetsMake(8.f, 8.f, 8.f, 8.f);
	
	MessageInputViewModel *viewModel = [[MessageInputViewModel alloc] initWithLayoutSpec:layoutSpec];
	viewModel.messageInputCornerRadius = 5.f;
	viewModel.messageInputBorderWidth = 0.5f;
	viewModel.messageInputBackgroundColor = [UIColor colorWithWhite:1 alpha:0.825f];
	viewModel.messageInputBorderColor = [UIColor colorWithWhite:0.5f alpha:0.4f];
	viewModel.messageInputFont = [UIFont systemFontOfSize:16];
	viewModel.messageInputFontColor = [UIColor darkTextColor];
	viewModel.sendButtonFont = [UIFont boldSystemFontOfSize:17.f];
	viewModel.backgroundToolbarName = @"backgroundToolbar";
	viewModel.inputTextViewName = @"inputTextView";
	viewModel.sendButtonName = @"sendButton";

	viewModel.layoutConstraints = @[
		@"H:|-[backgroundToolbar]|",
		@"V:|[backgroundToolbar]|",
		//@"H:[sendButton]-6-|",
		@"V:[sendButton]-4.5-|",
		[NSString stringWithFormat:@"H:|-%.2f-[inputTextView]-%.2f-[sendButton]-6-|", viewModel.layoutSpec.messageInputTextViewPadding.left, viewModel.layoutSpec.messageInputTextViewPadding.right],
		[NSString stringWithFormat:@"V:|-%.2f-[inputTextView]-%.2f-|", viewModel.layoutSpec.messageInputTextViewPadding.top, viewModel.layoutSpec.messageInputTextViewPadding.bottom],
	];
	
	return viewModel;
}

@end
