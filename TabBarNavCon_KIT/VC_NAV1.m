
#import "VC_NAV1.h"

@interface VC_NAV1 ()

@end

@implementation VC_NAV1
@synthesize  tap,txtfld1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"VC1 Title"];
        [self setUpInputs];
        [self buildNavBar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Standard UI Set Up
-(IBAction)goBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)done:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// "Return" key dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [txtfld1 resignFirstResponder];
    
    return YES;
}

-(void)buildNavBar{
    if(self.navigationController){
        
        UIBarButtonItem *addButton =[[UIBarButtonItem alloc]
                                     initWithTitle:@"Add"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(done:)];
        
        self.navigationItem.rightBarButtonItem = addButton;
        
    }
}

-(void)setUpInputs{
    txtfld1.delegate = self;
    
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard {
    [txtfld1 resignFirstResponder];
    
}

@end


