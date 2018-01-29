//
//  AGSpaceCell.m
//  AboveGEM
//
//  Created by traintrackcn on 8/12/14.
//
//

#import "AGSpaceCell.h"

@implementation AGSpaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
//        [self assembleView];
    }
    return self;
}

- (void)applySelectedStyle{
}

- (void)applyUnselectedStyle{
    
}

#pragma mark - 

//- (void)assembleView{
//    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
////    [self.remoter REQUEST:[NSURL URLWithString:@"http://beb.www.abovegem.com:11442/upload/image/93669/large_c1978034-21e6-43aa-ae2f-38b2d20d169d.jpg"] forImageView:v placeholderImage:nil];
//    UIImage *img = [UIImage imageNamed:@"BackgroundSignIn.jpg"];
//    [v setImage:img];
//    [self.contentView addSubview:v];
//}

@end
