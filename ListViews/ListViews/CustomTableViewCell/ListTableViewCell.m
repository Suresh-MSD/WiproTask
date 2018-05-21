//
//  ListTableViewCell.m
//  ListViews
//
//  Created by Suresh on 18/05/18.
//  Copyright © 2018 Suresh. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

@synthesize imageView, titleLabel, descriptionLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;

        // Initialization
        // Title Label
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setNumberOfLines:0];
        [self.contentView addSubview:self.titleLabel];
        // Description Label
        self.descriptionLabel = [[UILabel alloc] init];
        [self.descriptionLabel setNumberOfLines:0];
        [self.descriptionLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:self.descriptionLabel];
        // ImageView
        self.imageView = [[UIImageView alloc]init];
        [self.imageView setBackgroundColor:[UIColor clearColor]];
//        self.imageView.image = [UIImage imageNamed:@"PlaceHolder.jpg"];
        [self.contentView addSubview:self.imageView];
        
        //Setup AutoConstranints
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.imageView.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;

        [self addImageViewLayout];
        
    }
    return self;
}

-(void)addImageViewLayout {
    
    NSDictionary *views = @{@"imageView":self.imageView,@"title":self.titleLabel,@"description":self.descriptionLabel};
    NSDictionary *metrics = @{@"imageSize":@120.0,@"padding":@10.0};
    
    // Hugging for Label height
    [self.titleLabel setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisVertical];
    [self.descriptionLabel setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisVertical];

    // Define Horizontal layouts
    NSArray *horizontalTitleFromImage =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[imageView]-padding-[title]-padding-|" options:0 metrics:metrics views:views];
    NSArray *horizontalDescriptionFromImage =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[imageView]-padding-[description]-padding-|" options:0 metrics:metrics views:views];
    
    // Define Vertical layouts
    NSArray *verticalImageTop =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[imageView]->=padding@500-|" options:0 metrics:metrics views:views];
    NSArray *verticalTitleandDescription =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[title]-[description]->=padding-|" options:0 metrics:metrics views:views];
    
    // Define ImageView layouts
    NSArray *imageWidth = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(imageSize)]" options:0 metrics:metrics views:views];
    NSArray *imageHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(imageSize)]" options:0 metrics:metrics views:views];

    // Adding constraints to View
    [self.contentView addConstraints:horizontalTitleFromImage];
    [self.contentView addConstraints:horizontalDescriptionFromImage];
    [self.contentView addConstraints:verticalImageTop];
    [self.contentView addConstraints:verticalTitleandDescription];

    [self.imageView addConstraints:imageWidth];
    [self.imageView addConstraints:imageHeight];
}

#pragma mark - cell details

-(void)setterMethod:(DataModel *)data {
    if (data.title) {
        self.titleLabel.text = data.title;
    }
    
    if (data.detail) {
        self.descriptionLabel.text = data.detail;
    }
    
    if (data.imageURL) {
        [self setImageFromURL:data.imageURL];
    }
    
}

-(void)setImageFromURL:(NSURL*)imageURL {
    typeof(self) weakSelf = self;
    [self downloadImages:imageURL completion:^(NSData *imageData, NSError *error) {
        if (imageData) {
            UIImage *img = [[UIImage alloc] initWithData:imageData];
            // validate for refresh imageview
            if (weakSelf.imageView) {
                weakSelf.imageView.image = img;
            }
        }
    }];
}

-(void)downloadImages:(NSURL *)imgURL completion:(void (^)(NSData *imageData, NSError *error))completion {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            completion(data, nil);
        }else{
            NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"PlaceHolder.jpg"]);
            completion(data, nil);
            NSLog(@"%@",connectionError);
        }
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
