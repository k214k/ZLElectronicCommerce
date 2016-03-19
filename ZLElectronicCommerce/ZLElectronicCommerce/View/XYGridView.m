//
//  XYGridView.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/5.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYGridView.h"


#define KLINEPERCELLNUM (_titleArray.count/2)
@interface XYGridView()<UICollectionViewDelegate,UICollectionViewDataSource>
KPropertyStrong UICollectionView* collectionView;
KPropertyStrong NSMutableArray* titleArray;
KPropertyStrong NSMutableArray* tipArray;
@end
@implementation XYGridView
-(void)createData
{
    _titleArray = [NSMutableArray new];
    NSArray* array = @[@"天猫",@"聚划算",@"天猫国际",@"口碑外卖",@"天猫超市",@"充值中心",@"阿里旅行",@"领金币",@"淘生活",@"分类"];
    for (NSString* str in array)
    {
        XYGridModel* temp = [XYGridModel new];
        temp.nameStr = [str copy];
        temp.imagesStr = @"TaoBao";
        [_titleArray addObject:temp];
    }
    _tipArray = [NSMutableArray new];
    NSArray* array1 = @[@"天猫聚划算",@"天猫国际口碑外卖口碑外卖口碑外卖",@"天猫超市天猫国际天猫超市"];
    NSArray* array2 = @[@"口碑外卖充值中心充值中心充值中心",@"天猫超市阿里旅行阿里旅行阿里旅行",@"充值中心领金币领金币领金币领金币"];
    for (int i = 0;i < 3;++i)
    {
        XYGridFootModel* model = [XYGridFootModel new];
        model.firstStr = array1[i];
        model.secondStr = array2[i];
        [_tipArray addObject:model];
    }
    
}

-(void)createView
{
    [self addSubview:self.collectionView];
    
}

-(UICollectionView*)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init ];
        
        CGFloat itemWidth = floorf((kScreenWidth-40)/KLINEPERCELLNUM);
        CGFloat itemHeight = itemWidth;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(5,20,0,20);
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        if (_tipArray.count)
        {
            layout.footerReferenceSize = CGSizeMake(kScreenWidth, self.frame.size.height-itemWidth*2-2);//
        }
        
        
        _collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.clipsToBounds = YES;
        [_collectionView registerClass:[XYGridCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([XYGridCollectionViewCell class])];
        if (_tipArray.count)
        {
            [_collectionView registerClass:[XYGridCollectViewFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableView"];
        }

    }
    return _collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createData];
        [self createView];
    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYGridCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYGridCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = _titleArray[indexPath.row];
    return cell;
}

//foot部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    XYGridCollectViewFootView *footerView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        footerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        [footerView showTip:_tipArray];
        
    }
   
    return footerView;
}
@end
