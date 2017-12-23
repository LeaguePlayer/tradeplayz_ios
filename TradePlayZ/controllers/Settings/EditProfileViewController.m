//
//  EditProfileViewController.m
//  TradePlayZ
//
//  Created by Leonid Minderov on 15.12.17.
//  Copyright © 2017 Leonid Minderov. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init
    self.avatarPlace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 126, 126)];
    self.nameField = [[BaseTextField alloc] init];
    self.zipCodeField = [[BaseTextField alloc] init];
    self.addressField = [[BaseTextField alloc] init];
    self.emailField = [[BaseTextField alloc] init];
    self.phoneField = [[BaseTextField alloc] init];
    
    popup = [[UIActionSheet alloc] initWithTitle:[MCLocalization stringForKey:@"title_popup_camera"] delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:
                            [MCLocalization stringForKey:@"popup_camera"],
                            [MCLocalization stringForKey:@"popup_gallery"],
                            nil];
    popup.tag = 1;
    
    
    //test data
    [self initData];
}

-(void)initData
{
    
    [[[APIModel alloc] init] getUserProfileWithToken:self.authUser.token OnSuccess:^(NSDictionary *data) {
        NSDictionary* gotJson = [[data objectForKey:@"response"] objectForKey:@"user"];
        
        NSString* nameText = ( [[gotJson objectForKey:@"lastname"] isKindOfClass:[NSNull class]] || [[gotJson objectForKey:@"firstname"] isKindOfClass:[NSNull class]] ) ? @"" : [NSString stringWithFormat:@"%@ %@",[gotJson objectForKey:@"firstname"], [gotJson objectForKey:@"lastname"]];

        self.addressField.text = ( [[gotJson objectForKey:@"address"] isKindOfClass:[NSNull class]]  ) ? @"" : [gotJson objectForKey:@"address"];
        self.nameField.text = nameText;
        self.zipCodeField.text = ( [[gotJson objectForKey:@"zipcode"] isKindOfClass:[NSNull class]]  ) ? @"" :[gotJson objectForKey:@"zipcode"];
        self.emailField.text = ( [[gotJson objectForKey:@"email"] isKindOfClass:[NSNull class]]  ) ? @"" :[gotJson objectForKey:@"email"];
        self.phoneField.text = ( [[gotJson objectForKey:@"phone"] isKindOfClass:[NSNull class]]  ) ? @"" :[gotJson objectForKey:@"phone"];

        [self buildContent];
    } onFailure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    

    
}

-(void) buildContent
{

        float padding_top = 14.f;
        float padding_left = 35.f;
        float width_screen = self.revealViewController.rearViewRevealWidth - (padding_left*2);
        
        float top = padding_top;
        
        
        
        
        //row
        float paddingLeftTemp = (width_screen - 126)/2;
        if([self.authUser.img_avatar isKindOfClass:[NSNull class]])
            [self.avatarPlace setImage:[UIImage imageNamed:@"avatar"]];
        else
            [self.avatarPlace setImageWithURL:[NSURL URLWithString:self.authUser.img_avatar] placeholderImage:[UIImage imageNamed:@"avatar"]];
        self.avatarPlace.layer.cornerRadius = self.avatarPlace.frame.size.height/2;
        self.avatarPlace.clipsToBounds = YES;
        
        CGRect frameAvatarPlace = self.avatarPlace.frame;
        frameAvatarPlace.origin.x = padding_left+paddingLeftTemp;
        frameAvatarPlace.origin.y = padding_top;
        self.avatarPlace.frame = frameAvatarPlace;
        top += CGRectGetHeight(self.avatarPlace.frame) + 14.f;
    
    
    //row
    float width_button = 120.f;
    float  height_button = 35.f;
    paddingLeftTemp = (width_screen - width_button)/2;
    UIButton *changeImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeImage addTarget:self
                    action:@selector(changeImageAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [changeImage setTitle:[MCLocalization stringForKey:@"change_image"] forState:UIControlStateNormal];
    changeImage.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    [changeImage setTitleColor:[UIColor colorWithRed:0.33 green:0.50 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    [changeImage.titleLabel setTextAlignment:NSTextAlignmentCenter];
    changeImage.frame = CGRectMake( padding_left+paddingLeftTemp , top, width_button, height_button);
    
    NSMutableAttributedString* commentString = [[NSMutableAttributedString alloc] initWithString:changeImage.titleLabel.text];
    [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [changeImage.titleLabel.text length])];
    [changeImage setAttributedTitle:commentString forState:UIControlStateNormal];
    
    top += CGRectGetHeight(changeImage.frame) + 30.f;
    
    
    
    
    
    //row
    float height_field = 55.f;
    self.nameField.frame = CGRectMake(padding_left, top, width_screen, height_field);
    [self.nameField setPlaceHolderText:[MCLocalization stringForKey:@"your_name"]];
    self.nameField.tag = 0;
    self.nameField.delegate = self;
    top += height_field + 14.f;
    
    //row
    self.addressField.frame = CGRectMake(padding_left, top, width_screen, height_field);
    [self.addressField setPlaceHolderText:[MCLocalization stringForKey:@"your_address"]];
    self.addressField.tag = 1;
    self.addressField.delegate = self;
    top += height_field + 14.f;
    
    //row
    self.zipCodeField.frame = CGRectMake(padding_left, top, width_screen, height_field);
    [self.zipCodeField setPlaceHolderText:[MCLocalization stringForKey:@"your_zip"]];
    self.zipCodeField.tag = 2;
    [self.zipCodeField setKeyboardType:UIKeyboardTypeNamePhonePad ];
    self.zipCodeField.delegate = self;
    top += height_field + 14.f;
    
    //row
    self.emailField.frame = CGRectMake(padding_left, top, width_screen, height_field);
    [self.emailField setPlaceHolderText:[MCLocalization stringForKey:@"your_email"]];
    self.emailField.tag = 3;
    self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.emailField setKeyboardType:UIKeyboardTypeEmailAddress];
    self.emailField.delegate = self;
    top += height_field + 14.f;
    
    //row
    self.phoneField.frame = CGRectMake(padding_left, top, width_screen, height_field);
    [self.phoneField setPlaceHolderText:[MCLocalization stringForKey:@"your_phone"]];
    self.phoneField.tag = 4;
    [self.phoneField setKeyboardType:UIKeyboardTypeNamePhonePad];
    self.phoneField.delegate = self;
    top += height_field + 36.f;
    
    //row
    width_button = 226.5f;
    height_button = 55.f;
    paddingLeftTemp = (width_screen - width_button)/2;
    BaseButton *confirmButton = [BaseButton buttonWithType:UIButtonTypeCustom];
    [confirmButton addTarget:self
                        action:@selector(confirmAction:)
              forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setTitle:[[MCLocalization stringForKey:@"confirm"] uppercaseString] forState:UIControlStateNormal];
    confirmButton.frame = CGRectMake(paddingLeftTemp+padding_left , top, width_button, height_button);
    //
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:confirmButton.titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName value:@3.f range:NSMakeRange(0, [confirmButton.titleLabel.text length])];
    [confirmButton.titleLabel setAttributedText:attributedString];
    
    top += CGRectGetHeight(confirmButton.frame) + padding_top;
    
    //
   [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), top)];
        
        //add subviews
        [self.scrollView addSubview:self.avatarPlace];
    [self.scrollView addSubview:self.nameField];
     [self.scrollView addSubview:self.addressField];
     [self.scrollView addSubview:self.zipCodeField];
     [self.scrollView addSubview:self.emailField];
     [self.scrollView addSubview:self.phoneField];
    [self.scrollView addSubview:changeImage];
    [self.scrollView addSubview:confirmButton];
}


-(void)confirmAction:(id)sender
{
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"confirmAction");
    NSDictionary* profileParams = @{
                                 @"name":self.nameField.text,
                                 @"address": self.addressField.text,
                                 @"zipcode": self.zipCodeField.text,
                                 @"email": self.emailField.text,
                                 @"phone": self.phoneField.text,
//                                 @"img_avatar": @"filename.png",
                                 };
    
    
    [self.authUser editProfileWithParams:profileParams andAvatarImage:self.avatarPlace.image OnSuccess:^(NSDictionary *data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } onFailure:^(NSString *error) {
        NSLog(@"bad");
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
//    [self.authUser editProfileWithParams:profileParams andAvatarImage:self.avatarPlace.image OnSuccess:^(NSDictionary *data) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } onFailure:^(NSString *error) {
//        NSLog(@"bad");
//    }];
}

-(void)changeImageAction:(id)sender
{
    NSLog(@"changeImageAction");
    
    [popup showInView:self.view];
}

- (void)takePhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.avatarPlace.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
  
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    NSLog(@"camera");
                    [self takePhoto];
                    break;
                case 1:
                    [self selectPhoto];
                    break;
                
            
            }
            break;
        }
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    _avatarPlace.image = image;
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}


- (IBAction)saveImage:(id)sender {
    if(_avatarPlace.image) {
//        [self showProgressIndicator:@"Saving"];
        UIImageWriteToSavedPhotosAlbum(_avatarPlace.image, self, @selector(finishUIImageWriteToSavedPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
