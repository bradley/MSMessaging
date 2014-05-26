//
//  MessageViewController.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/24/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageBubbleController.h"
#import "MessageInputView.h"
#import "MessageBubbleCell.h"

@interface MessageViewController () <MessageInputViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) MessageInputView *messageInputView;
@property (nonatomic, strong) NSLayoutConstraint *keyboardConstraint;
@property (nonatomic, strong) MessageBubbleController *messageBubbleController;

- (void)closeKeyboard:(id)sender;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

- (void)sendPressed:(id)sender;

@end

@implementation MessageViewController

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.translatesAutoresizingMaskIntoConstraints = NO;
	
	self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.alwaysBounceVertical = YES;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.view addSubview:self.collectionView];
	[self.collectionView registerClass:[MessageBubbleCell class] forCellWithReuseIdentifier:@"messageCell"];

	self.messageInputView = [[MessageInputView alloc] init];
	self.messageInputView.delegate = self;
	[self.view addSubview:self.messageInputView];

	self.messageBubbleController = [[MessageBubbleController alloc] init];
	self.messageBubbleController.collectionViewSize = self.view.bounds.size;
	self.messageInputView.viewModel = [self.messageBubbleController viewModel];
	self.messageInputView.delegate = self;
		
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.messageInputView action:@selector(endEditing:)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (void)setMaxKeyboardLayoutGuide:(id<UILayoutSupport>)maxKeyboardLayoutGuide
{
	_maxKeyboardLayoutGuide = maxKeyboardLayoutGuide;
	
	NSDictionary *views = @{
		@"collectionView" : self.collectionView,
		@"messageInputView" : self.messageInputView
	};
	
	self.keyboardConstraint = [NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.messageInputView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
	NSLayoutConstraint *maxKeyboardConstraint = [NSLayoutConstraint constraintWithItem:self.messageInputView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.f constant:self.maxKeyboardLayoutGuide.length - [UIApplication sharedApplication].statusBarFrame.size.height];
	
	[self.view addConstraint:self.keyboardConstraint];
	[self.view addConstraint:maxKeyboardConstraint];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[messageInputView]|" options:0 metrics:nil views:views]];

	UIEdgeInsets contentInset = self.collectionView.contentInset;
	contentInset.top += _maxKeyboardLayoutGuide.length;
	contentInset.bottom += self.messageInputView.intrinsicContentSize.height;
	self.collectionView.contentInset = contentInset;
	
	UIEdgeInsets scrollIndicatorInsets = self.collectionView.scrollIndicatorInsets;
	scrollIndicatorInsets.top += _maxKeyboardLayoutGuide.length;
	scrollIndicatorInsets.bottom += self.messageInputView.intrinsicContentSize.height;
	self.collectionView.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (void)reloadData
{
	[self.collectionView reloadData];
}

- (void)closeKeyboard:(id)sender
{
	[self.messageInputView endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	UIViewAnimationCurve animationCurve;
	NSTimeInterval animationDuration;
	CGRect keyboardRect;
	
	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	{
		self.keyboardConstraint.constant = keyboardRect.size.height;

		[self.view layoutIfNeeded];
		
		UIEdgeInsets contentInset = self.collectionView.contentInset;
		contentInset.bottom += keyboardRect.size.height;
		self.collectionView.contentInset = contentInset;
		
		UIEdgeInsets scrollIndicatorInsets = self.collectionView.scrollIndicatorInsets;
		scrollIndicatorInsets.bottom += keyboardRect.size.height;
		self.collectionView.scrollIndicatorInsets = scrollIndicatorInsets;
	}
	
	[UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	UIViewAnimationCurve animationCurve;
	NSTimeInterval animationDuration;
	CGRect keyboardRect;
	
	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
		
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	{
		self.keyboardConstraint.constant = 0.f;

		[self.view layoutIfNeeded];
		
		UIEdgeInsets contentInset = self.collectionView.contentInset;
		contentInset.bottom -= keyboardRect.size.height;
		self.collectionView.contentInset = contentInset;
		
		UIEdgeInsets scrollIndicatorInsets = self.collectionView.scrollIndicatorInsets;
		scrollIndicatorInsets.bottom -= keyboardRect.size.height;
		self.collectionView.scrollIndicatorInsets = scrollIndicatorInsets;
	}
		
	[UIView commitAnimations];
}

- (void)sendPressed:(id)sender
{
	[self.messageInputView clearInputText];
}

#pragma mark MessageInputViewDelegate

- (void)messageInputViewDidChangeText:(MessageInputView *)messageInputView
{
	[messageInputView scrollToCaret];
}

- (void)messageInputView:(MessageInputView *)messageInputView didSendMessageText:(NSString *)messageText
{
	[self.messageInputView clearInputText];
	[self.delegate messageViewController:self didSendMessageText:messageText];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	Message *message = [self.delegate messageAtIndexPath:indexPath];
	MessageBubbleViewModel *viewModel = [self.messageBubbleController viewModelForMessageText:message.messageText isAuthor:message.isAuthor];
	return [viewModel.layoutSpec cellSize];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	for (MessageBubbleCell *cell in self.collectionView.visibleCells) {
		cell.gradientOffset = (-self.collectionView.contentOffset.y + cell.frame.origin.y);
	}
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.delegate messageCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	Message *message = [self.delegate messageAtIndexPath:indexPath];
	MessageBubbleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"messageCell" forIndexPath:indexPath];
	if (message && cell) {
		UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
		MessageBubbleViewModel *viewModel = [self.messageBubbleController viewModelForMessageText:message.messageText isAuthor:message.isAuthor];
		[cell setViewModel:viewModel];
		cell.gradientOffset = (-self.collectionView.contentOffset.y + attributes.frame.origin.y);
	}
	
	return cell;
}

@end
