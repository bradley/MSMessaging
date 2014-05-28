//
//  MSMessageInputViewModel.m
//  MSMessaging
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MSMessageInputViewModel.h"

@interface MSMessageInputViewModel ()

@property (nonatomic, strong) MSMessageInputLayoutSpec *layoutSpec;

@end

@implementation MSMessageInputViewModel

- (instancetype)initWithLayoutSpec:(MSMessageInputLayoutSpec *)layoutSpec
{
	self = [super init];
	if (self) {
		self.layoutSpec = layoutSpec;
	}
	
	return self;
}

@end
