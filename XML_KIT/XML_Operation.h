//
//  Operation.h
//  XMLTest
//
//  Created by frederick forte on 10/27/13.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "XMLDictionary.h"

@interface XML_Operation : NSObject
{
    NSManagedObjectContext  *managedObjectContext;
    
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

//XML
-(void)getXMLDataIntoCoreData;
// COMMENT OUT TILL CORE DATA IS SET UP
//-(void)populateCoreDataWithJSONDictionary:(NSDictionary*)JSONDictionary;
-(void)createApplication;
-(NSMutableArray *)readApplication;
@end


