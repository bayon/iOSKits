
#import <UIKit/UIKit.h>

@interface VC_NAV2 : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITextField *txtfld1;
    UITapGestureRecognizer *tap;
}

@property  (nonatomic,retain) IBOutlet UITextField *txtfld1;
@property  (nonatomic,retain) UITapGestureRecognizer *tap;
-(IBAction)goBack:(id)sender;
-(IBAction)done:(id)sender;


@end
