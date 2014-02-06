//
//  Utility.h
//  CCCalc
//
//  Created by frederick forte on 10/28/13.
//
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
{
    NSManagedObjectContext  *managedObjectContext;
    NSString *selectedStatementCode;
}


+ (id)sharedUtility;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) UIFont *mainFontBig;
@property (nonatomic,retain) UIFont *mainFontMedium;
@property (nonatomic,retain) UIFont *mainFontSmall;


@end

