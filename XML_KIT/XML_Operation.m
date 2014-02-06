//
//  Operation.m
//  XMLTest
//
//  Created by frederick forte on 10/27/13.
//
//

#import "XML_Operation.h"



@implementation XML_Operation
@synthesize managedObjectContext;



-(void)getXMLDataIntoCoreData{
    // XML to XMLDictionary: requires code: XMLDictionary.h and .m
    NSURL *URL = [[NSURL alloc] initWithString:@"http://www.corestandards.org/Math.xml"];
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:string];
    //XMLDictionary to JSON
    NSError *error;
    // // Pass 0 to options , if you don't care about the readability of the generated string
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:xmlDoc
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc]init];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",jsonString);
    }
    
    
    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // self.viewController = [[CCMathCodeViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //self.viewController.jsonStringData = jsonString;
    //  INSTEAD OF JUST PASSING THE DATA STRING ON...
    // Use/Convert OperationDownloadData.m to save data to CORE DATA
    // then use at will........
    
    //JSON string TO NSDictionary
    NSError *e = [[NSError alloc]init];
    NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    
    NSLog(@"\n JSON Dictionary: %@",JSON );
    
    // COMMENT OUT UNTIL CORE DATA IS SET UP
   // [self populateCoreDataWithJSONDictionary:JSON];
    
    
    
}

#pragma mark- Populate Core Data
/*
-(void)populateCoreDataWithJSONDictionary:(NSDictionary*)JSONDictionary
{
    
    //NSLog(@"\n FILE->FUNCTION: %s",__FUNCTION__);
    if (managedObjectContext == nil)
    {
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    //NSLog(@"Dictionary at populateCoreData: %@",JSONDictionary);
    
    for (id key in JSONDictionary) {
        
        if ([key isEqualToString:@"LearningStandardItem"])
        {
            NSArray *attributes = [JSONDictionary objectForKey:key];
            
            
            
            
            
            
            //NSLog(@"attributes populateCoreData: %@",attributes);
            
            for (id LearningStandardObject in attributes) {
                //check for duplicates
                
                //UNCOMMENT ONCE EVERYTHING IS LOADING IN THEN CHECK AGAIN.
                if (![self findDuplicateForID: [LearningStandardObject objectForKey:@"RefURI"] inEntity:@"LearningStandardItem"])
                {
                    
                    //-- -- -- -- -- -- -- -- -- --
                    LearningStandardItem *learningStandardItem = [NSEntityDescription
                                                                  insertNewObjectForEntityForName:@"LearningStandardItem"
                                                                  inManagedObjectContext:managedObjectContext];
                    
                    
                    
                    //check *
                    learningStandardItem.refURI =[LearningStandardObject objectForKey:@"RefURI"];
                    //check *
                    learningStandardItem.documentRefId = [LearningStandardObject objectForKey:@"LearningStandardDocumentRefId"];
                    
                    // Dive Into The Parsing For These
                    
                    
                    
                    //inside of "Statements"
                    learningStandardItem.statement = [LearningStandardObject objectForKey:@"Statement"];
                    //inside of "StandardHierarchyLevel"
                    learningStandardItem.hierarchyLevel = [NSNumber numberWithInt:[[LearningStandardObject objectForKey:@"number"]integerValue]];
                    learningStandardItem.hierarchyDescription = [LearningStandardObject objectForKey:@"description"];
                    

                    
                    
                    
                    
        
                    for(id key in LearningStandardObject) {
                        id value = [LearningStandardObject objectForKey:key];
                        BOOL valueIsDictionary = [value isKindOfClass:[NSDictionary class]];
                        
                            // NSLog(@"Value is NOT an Array");
                            NSString *keyAsString = (NSString *)key;
                            NSString *valueAsString = (NSString *)value;
                            //NSLog(@"\n>key: %@ value: %@", keyAsString, valueAsString);
                        
                        
                        if(valueIsDictionary){
                            
                            for(id k in value){
                                id v = [value objectForKey:k];
                                NSString *kAsString = (NSString *)k;
                                NSString *vAsString = (NSString *)v;
                                //NSLog(@"\n>k: %@ v: %@", kAsString,vAsString );
                                
                                //SELECT SPECIFIC
                                //NSLog(@"\n %@",[value objectForKey:@"key1"]);
                                 //CLASS TYPE IS ? 
                                //NSLog(@"\n >>>CLASS TYPE: v:  %@", [[v class] description]);
                                //v can be:
                                //NSArray
                                //NSDictionary
                                //NSCFString
                                BOOL vIsNSDictionary = [v isKindOfClass:[NSDictionary class]];
                                BOOL vIsNSArray = [v isKindOfClass:[NSArray class]];
                                BOOL vIsNSString = [v isKindOfClass:[NSString class]];
                                
                                if(vIsNSString)
                                {
                                    //NSLog(@"\nvIsNSString :%@ - %@",k,v);
                                    //the value I want
                                    //GradeLevel, Statement, StatementCode, number, description,
                                    //--------------------------------------------------------------------
                                    if([k isEqualToString:@"GradeLevel"]){
                                         // BUT NOT AN ARRAY
                                        if(!vIsNSArray){
                                            learningStandardItem.gradeLevel = v;
                                        }
                                    }
                                    if([k isEqualToString:@"Statement"]){
                                        //inside of "Statements"
                                        learningStandardItem.statement = v;
                                    }
                                    if([k isEqualToString:@"StatementCode"]){
                                        learningStandardItem.statementCode = v;
                                    }
                                    if([k isEqualToString:@"number"]){
                                        //inside of "Statements"
                                        //learningStandardItem.hierarchyLevel = v;
                                        //reason: 'Unacceptable type of value for attribute: property = "hierarchyLevel"; desired type = NSNumber; given type = __NSCFString; value = 7.'
                                        
                                        //number values
                                         learningStandardItem.hierarchyLevel = [NSNumber numberWithInt:[v integerValue]];
                                        
                                    }
                                    if([k isEqualToString:@"description"]){
                                        learningStandardItem.hierarchyDescription = v;
                                    }
                                    
                                }else if(vIsNSArray)
                                {
                                   
                                    // GRADE LEVELS
                                    //NSLog(@"\nvIsNSArray :%@",v);
                                    
                                    //probably just convert array to string and save
                                    
                                    
                                    int i;
                                    NSString *myString = [NSString stringWithFormat:@"{"];
                                    
                                    for (i = 0; i < [v count]; i++) {
                                        myString = [NSString stringWithFormat:@"%@,%@", myString , [v objectAtIndex:i ]];
                                    }
                                    //NSLog(@"\n String from Array: %@",myString);
                                    NSString *gradeLevelsArrayToString = [NSString stringWithFormat:@"}"];
                                    gradeLevelsArrayToString= [NSString stringWithFormat:@"%@,%@", myString , gradeLevelsArrayToString];
                                    //NSLog(@"\n finalResult: String from Array: %@",gradeLevelsArrayToString);
                                    // GRADE LEVELS = finalResult
                                    //--------------------------------------------------------------------
                                    //inside of GradeLevels
                                    learningStandardItem.gradeLevel =  gradeLevelsArrayToString;
                                    
                               
                                
                                }else if(vIsNSDictionary)
                                {
                                    //NSLog(@"\nvIsNSDictionary :%@",v);
 
                                    
                                    for(id k2 in v){
                                        id v2 = [v objectForKey:k2];
                                        NSString *k2AsString = (NSString *)k2;
                                        NSString *v2AsString = (NSString *)v2;
                                        //NSLog(@"\n>k2: %@ v2: %@", k2AsString,v2AsString );
 
                                        //DON'T CARE ABOUT THESE RIGHT NOW
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
         
 
                    
                    //->->->->->->
                    
                    
                    
                    
                    // I think I might need to save it HERE for each object.
                    
                    
                }
                
                
            }
        }
        else if ([key isEqualToString:@"entity"])
        {
            NSArray *arrayOfEntity = [JSONDictionary objectForKey:key];
            for (id entityObject in arrayOfEntity)
            {
                //handle the details
                
            }
        }
        //....else if infinity-->
 
        
        
    }
    
    //set application to "hasInitialData"
    
   // Utility *sharedUtility = [Utility sharedUtility];
    //[sharedUtility createApplication];
    [self createApplication];
    
    
    
    
    
    
    // THE SAVE
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Problem saving: %@",[error localizedDescription]);
    }
    
    //post
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_CoreDataPopulated" object:nil];
    //[self dataFinishedLoading];
    
    
}
*/
#pragma mark- Core Data Utility Methods


-(BOOL)findDuplicateForID:(NSString*)miscID inEntity:(NSString*)Entity
{
    if (managedObjectContext == nil)
    {
        //managedObjectContext = [(FMSAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    NSError *fetchError;
    NSPredicate *predicate;
    NSFetchRequest *currentFetch = [[NSFetchRequest alloc]initWithEntityName:Entity];
    /*
     objectForKey:@"RefURI"]integerValue]] inEntity:@"LearningStandardItem"])
     */
    if ([Entity isEqualToString:@"LearningStandardItem"]) {
        predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"refURI == '%@'",miscID]];
    }
    
    currentFetch.predicate = predicate;
    NSArray *array = [managedObjectContext executeFetchRequest:currentFetch error:&fetchError];
    if (array.count > 0) {
        return true;
    }
    else
    {
        return false;
    }
}


/*
 {
 GradeLevels =         {
 GradeLevel = K;
 };
 LearningStandardDocumentRefId = B62C1C106873438AA0126760075A65A3;
 RefURI = "http://corestandards.org/Math/Content/K/CC/A/1/";
 RelatedLearningStandardItems =         {
 LearningStandardItemRefId =             {
 "_RelationshipType" = childOf;
 "__text" = 4F4106218F834258BCDDB7EB39806880;
 };
 };
 StandardHierarchyLevel =         {
 description = Standard;
 number = 7;
 };
 StatementCodes =         {
 StatementCode = "CCSS.Math.Content.K.CC.A.1";
 };
 Statements =         {
 Statement = "Count to 100 by ones and by tens.";
 };
 "_RefID" = CA9EE2E34F384E95A5FA26769C5864B8;
 "_xml:lang" = en;
 },
 
 
 */

-(void)createApplication{
    if (managedObjectContext == nil)
    {
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    NSManagedObject	*entityX = [NSEntityDescription insertNewObjectForEntityForName:@"Application" inManagedObjectContext:managedObjectContext];
    NSError *err;
    //convert int to NSNumber
    NSNumber *yes = [NSNumber numberWithInt:1];
    
    [entityX setValue:yes forKey:@"hasInitialData"];
    if (![managedObjectContext save:&err])
    {
        NSLog(@"Problem saving: %@", [err localizedDescription]);
    }else{
        NSLog(@"SAVE COMPLETE.");
    }
}


-(NSMutableArray *)readApplication{
    if (managedObjectContext == nil)
    {
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Application" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *data =   [NSMutableArray arrayWithArray:fetchedObjects];
    
    return data;
}



@end
