//
//  Utility.m
//  CCCalc
//
//  Created by frederick forte on 10/28/13.
//
//

#import "Utility.h"

@implementation Utility
@synthesize managedObjectContext;
@synthesize mainFontBig,mainFontMedium,mainFontSmall  ;

+ (id)sharedUtility {
    static Utility *sharedUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtility = [[self alloc] init];
    });
    return sharedUtility;
}

- (id)init {
    if (self = [super init]) {
        selectedStatementCode = [NSString stringWithFormat:@""];
        mainFontBig = [UIFont fontWithName:@"Helvetica" size:23.0];
        mainFontMedium = [UIFont fontWithName:@"Helvetica" size:18.0];
        mainFontSmall = [UIFont fontWithName:@"Helvetica" size:10.0];
    }
    return self;
}

@end
