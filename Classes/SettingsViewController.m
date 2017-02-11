#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize defaults, mySettingsArray, currentDict;
@synthesize myTableView, pressedCellDict, curCellType;
@synthesize window, imgPreview, btnClosePreview, btnDetailDisclosure;

-(void)viewDidLoad
{
    [super viewDidLoad];
	window.hidden = YES;
	[self.view bringSubviewToFront:window];
	
	[myTableView reloadData];
	defaults = [NSUserDefaults standardUserDefaults];
}

-(void)viewDidAppear:(BOOL)animated
{
	[myTableView reloadData];
}

-(void)setSettingsArray:(NSMutableArray *)array
{
	self.mySettingsArray = array;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
    [super dealloc];
}

-(void)soundFinishedPlaying:(Sound *)sound
{
	[sound release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [mySettingsArray count];
}

-(NSInteger)tableView:(UITableView *)tableView 
		numberOfRowsInSection:(NSInteger)section
{
	return [[mySettingsArray objectAtIndex:section] count];
}

-(NSString *)tableView:(UITableView *)tableView
		titleForHeaderInSection:(NSInteger)section
{
	switch (section) {
		case kMotionTouchSettings:
			return @"Motion & Touch";
			break;
		case kMessageAlertSettings:
			return @"Message Alert";
			break;
		case kFrightNightSettings:
			return @"Fright Night";
			break;
		case kScareSoundSettings:
			return @"Scare Sound";
			break;
		case kScareImageSettings:
			return @"Scare Image";
			break;
		case kSafeImageSettings:
			return @"Safe Image";
			break;
		default:
			return @"";
			break;
	}
}

-(CGFloat)tableView:(UITableView *)tableView
		heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.currentDict = [[mySettingsArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
	self.curCellType = [self.currentDict objectForKey:@"CellType"];
	
	if ([self.curCellType isEqualToString:@"SliderCellIdentifier"])
	{
		return 65;
	}
	else
	{
		return 44;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *SimpleCellIdentifier = @"SimpleCellIdentifier";
	static NSString *SwitchCellIdentifier = @"SwitchCellIdentifier";
	static NSString *PreviewButtonCellIdentifier = @"PreviewButtonCellIdentifier";
	static NSString *SliderCellIdentifier = @"SliderCellIdentifier";
	
	self.currentDict = [[mySettingsArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
	
	self.curCellType = [self.currentDict objectForKey:@"CellType"];
	
	if ([self.curCellType isEqualToString:SwitchCellIdentifier])
	{
		SwitchCell *cell = (SwitchCell *)[tableView dequeueReusableCellWithIdentifier:SwitchCellIdentifier];
		
		if (cell == nil)
		{
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchCell" owner:self options:nil];
			cell = [nib objectAtIndex:0];
		}
		
		cell.mySwitch.tag = ([indexPath row] - 3);
		
		if ([[currentDict objectForKey:@"HasDetail"] boolValue])
			cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		else
			cell.accessoryType = UITableViewCellAccessoryNone;
		
		cell.caption.text = [currentDict objectForKey:@"Caption"];
		
		[cell.mySwitch addTarget:self action:@selector(changedCreepySoundSwitch:) 
				  forControlEvents:UIControlEventValueChanged];
		
		BOOL value;
		switch ([indexPath section])
		{
			case kFrightNightSettings:
				value = [defaults boolForKey:[NSString stringWithFormat:@"CreepySound%.2dKey", ([indexPath row] - 3)]];
				break;
			default:
				break;
		}
		cell.mySwitch.on = value;
		
		return cell;
	}
	else if ([self.curCellType isEqualToString:PreviewButtonCellIdentifier])
	{
		PreviewButtonCell *cell = (PreviewButtonCell *)[tableView dequeueReusableCellWithIdentifier:PreviewButtonCellIdentifier];
		
		if (cell == nil)
		{
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PreviewButtonCell" owner:self options:nil];
			cell = [nib objectAtIndex:0];
		}
		
		cell.btnPreview.tag = [indexPath row];
		
		switch ([indexPath section])
		{
			case kMotionTouchSettings:
				break;
			case kMessageAlertSettings:
				break;
			case kFrightNightSettings:
				if ([indexPath row] > 2)
				{
					[cell.btnPreview addTarget:self action:@selector(pressedDetailCreepySound:) 
						  forControlEvents:UIControlEventTouchUpInside];
				}
				break;
			case kScareSoundSettings:
				[cell.btnPreview addTarget:self action:@selector(pressedDetailScareSound:) 
						  forControlEvents:UIControlEventTouchUpInside];
				
				if ([defaults integerForKey:@"ScareSoundKey"] == [indexPath row])
					cell.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					cell.accessoryType = UITableViewCellAccessoryNone;
				
				break;
			case kScareImageSettings:
				[cell.btnPreview addTarget:self action:@selector(pressedDetailPicture:) 
						  forControlEvents:UIControlEventTouchUpInside];
				
				if ([defaults integerForKey:@"ScareImageKey"] == [indexPath row])
					cell.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					cell.accessoryType = UITableViewCellAccessoryNone;
				
				break;
			case kSafeImageSettings:
				[cell.btnPreview addTarget:self action:@selector(pressedDetailSafePicture:) 
						  forControlEvents:UIControlEventTouchUpInside];
				
				if ([defaults integerForKey:@"SafeImageKey"] == [indexPath row])
					cell.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					cell.accessoryType = UITableViewCellAccessoryNone;
				
				break;
			default:
				break;
		}
		
		
		cell.caption.text = [currentDict objectForKey:@"Caption"];
		
		return cell;
	}
	else if ([self.curCellType isEqualToString:SliderCellIdentifier])
	{
		SliderCell *cell = (SliderCell *)[tableView dequeueReusableCellWithIdentifier:SliderCellIdentifier];
		
		if (cell == nil)
		{
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SliderCell" owner:self options:nil];
			cell = [nib objectAtIndex:0];
		}
		
		cell.slider.tag = [indexPath row];
		
		cell.lblCaption.text = [currentDict objectForKey:@"Caption"];
		cell.slider.minimumValue = [[currentDict objectForKey:@"SliderMin"] floatValue];
		cell.slider.maximumValue = [[currentDict objectForKey:@"SliderMax"] floatValue];
		
		switch ([indexPath section])
		{
			case kMotionTouchSettings:
				[cell.slider addTarget:self action:@selector(changedMotionTouchSlider:) 
					  forControlEvents:UIControlEventValueChanged];
				break;
			case kMessageAlertSettings:
				[cell.slider addTarget:self action:@selector(changedMessageAlertSlider:) 
					  forControlEvents:UIControlEventValueChanged];
				break;
			case kFrightNightSettings:
				[cell.slider addTarget:self action:@selector(changedFrightNightSlider:) 
					  forControlEvents:UIControlEventValueChanged];
				break;
			default:
				break;
		}
		
		float value = 0.0;
		switch ([indexPath section])
		{
			case kMotionTouchSettings:
				value = [defaults floatForKey:@"GForceValueKey"];
				break;
			case kMessageAlertSettings:
				value = [defaults floatForKey:@"MessageDelayKey"];
				break;
			case kFrightNightSettings:
				switch ([indexPath row])
			{
				case kFNS_MinInterval:
					value = [defaults floatForKey:@"MinIntervalKey"];
					break;
				case kFNS_MaxInterval:
					value = [defaults floatForKey:@"MaxIntervalKey"];
					break;
				case kFNS_TotalDuration:
					value = [defaults floatForKey:@"TotalDurationKey"];
					break;
				default:
					break;
			}
				break;
			default:
				break;
		}
		
		cell.slider.value = value;
		
		if ([[currentDict objectForKey:@"Exponential"] boolValue])
			cell.lblValue.text = [NSString stringWithFormat:@"%2.2f", (pow(cell.slider.value, 3) + 0.1)];
		else
			cell.lblValue.text = [NSString stringWithFormat:@"%2.2f", cell.slider.value];
		
		if (([indexPath section] == kMotionTouchSettings) && (cell.slider.value == cell.slider.maximumValue))
			cell.lblValue.text = @"10.00";
		else if (([indexPath section] == kMessageAlertSettings) && ([cell.lblValue.text floatValue] > 90.0))
			cell.lblValue.text = @"90.0";
		return cell;
	}
	else
	{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleCellIdentifier];
		
		if (cell == nil)
		{
			//cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier: SimpleCellIdentifier] autorelease];
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleCellIdentifier] autorelease];
		}
		
		cell.textLabel.text = [currentDict objectForKey:@"Caption"];
		
		return cell;
	}
}

-(NSIndexPath *)tableView:(UITableView *)tableView
		willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	NSIndexPath *ip;
	
	switch ([indexPath section])
	{
		case kScareSoundSettings:
			[defaults setInteger:[indexPath row] forKey:@"ScareSoundKey"];
			
			for (int x=0; x < [[mySettingsArray objectAtIndex:[indexPath section]] count]; x++)
			{
				ip = [NSIndexPath indexPathForRow:x inSection:[indexPath section]];
				cell = [tableView cellForRowAtIndexPath:ip];
				
				if (x == [defaults integerForKey:@"ScareSoundKey"])
					cell.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					cell.accessoryType = UITableViewCellAccessoryNone;
			}
			break;
		case kScareImageSettings:
			[defaults setInteger:[indexPath row] forKey:@"ScareImageKey"];
			
			for (int x=0; x < [[mySettingsArray objectAtIndex:[indexPath section]] count]; x++)
			{
				ip = [NSIndexPath indexPathForRow:x inSection:[indexPath section]];
				cell = [tableView cellForRowAtIndexPath:ip];
				
				if (x == [defaults integerForKey:@"ScareImageKey"])
					cell.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					cell.accessoryType = UITableViewCellAccessoryNone;
			}
			break;
		case kSafeImageSettings:
			[defaults setInteger:[indexPath row] forKey:@"SafeImageKey"];
			
			for (int x=0; x < [[mySettingsArray objectAtIndex:[indexPath section]] count]; x++)
			{
				ip = [NSIndexPath indexPathForRow:x inSection:[indexPath section]];
				cell = [tableView cellForRowAtIndexPath:ip];
				
				if (x == [defaults integerForKey:@"SafeImageKey"])
					cell.accessoryType = UITableViewCellAccessoryCheckmark;
				else
					cell.accessoryType = UITableViewCellAccessoryNone;
			}
			break;
		default:
			break;
	}
	
	return nil;
}

-(void)tableView:(UITableView *)tableView
		accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath section] == kFrightNightSettings)
	{
		Sound *snd = [[Sound alloc] init];
		
		snd.name = [NSString stringWithFormat:@"SndCreepy%.2d", ([indexPath row] - 3)];
		[snd playSound];
	}
}

-(void)changedCreepySoundSwitch:(id)sender
{
	[defaults setBool:((UISwitch *)sender).on forKey:[NSString stringWithFormat:@"CreepySound%.2dKey", ((UISwitch *)sender).tag]];
}

-(void)changedMotionTouchSlider:(id)sender
{
	NSDictionary *curDict;
	
	switch (((UISlider *)sender).tag)
	{
		case kMTS_GForceValue:
			curDict = [[mySettingsArray objectAtIndex:kMotionTouchSettings] objectAtIndex:((UISlider *)sender).tag];
			
			[defaults setFloat:((UISlider *)sender).value forKey:@"GForceValueKey"];
			UITableViewCell *cell;
			NSIndexPath *ip = [NSIndexPath indexPathForRow:((UISlider *)sender).tag inSection:kMotionTouchSettings];
			cell = [myTableView cellForRowAtIndexPath:ip];
			
			if ([[curDict objectForKey:@"Exponential"] boolValue])
				((SliderCell *)cell).lblValue.text = [NSString stringWithFormat:@"%2.2f", (pow(((SliderCell *)cell).slider.value, 3) + 0.1)];
			else
				((SliderCell *)cell).lblValue.text = [NSString stringWithFormat:@"%2.2f", ((SliderCell *)cell).slider.value];
			
			if (((UISlider *)sender).value == ((UISlider *)sender).maximumValue)
				((SliderCell *)cell).lblValue.text = @"10.00";
			
			break;
		default:
			break;
	}
}

-(void)changedMessageAlertSlider:(id)sender
{
	NSDictionary *curDict;
	
	switch (((UISlider *)sender).tag)
	{
		case kMAS_TimeDelay:
			curDict = [[mySettingsArray objectAtIndex:kMessageAlertSettings] objectAtIndex:((UISlider *)sender).tag];
			
			[defaults setFloat:((UISlider *)sender).value forKey:@"MessageDelayKey"];
			UITableViewCell *cell;
			NSIndexPath *ip = [NSIndexPath indexPathForRow:((UISlider *)sender).tag inSection:kMessageAlertSettings];
			cell = [myTableView cellForRowAtIndexPath:ip];
			
			if ([[curDict objectForKey:@"Exponential"] boolValue])
				((SliderCell *)cell).lblValue.text = [NSString stringWithFormat:@"%2.2f", (pow(((SliderCell *)cell).slider.value, 3) + 0.1)];
			else
				((SliderCell *)cell).lblValue.text = [NSString stringWithFormat:@"%2.2f", ((SliderCell *)cell).slider.value];
			
			if ([((SliderCell *)cell).lblValue.text floatValue] > 90.0)
				((SliderCell *)cell).lblValue.text = @"90.0";
			
			break;
		default:
			break;
	}
}

-(void)changedFrightNightSlider:(id)sender
{
	NSDictionary *curDict;
	
	switch (((UISlider *)sender).tag)
	{
		case kFNS_MinInterval:
			[defaults setFloat:((UISlider *)sender).value forKey:@"MinIntervalKey"];
			
			if ([defaults floatForKey:@"MinIntervalKey"] > [defaults floatForKey:@"MaxIntervalKey"])
			{
				UITableViewCell *cellMax;
				NSIndexPath *ipMax;
				
				[defaults setFloat:[defaults floatForKey:@"MinIntervalKey"] forKey:@"MaxIntervalKey"];
				ipMax = [NSIndexPath indexPathForRow:kFNS_MaxInterval inSection:kFrightNightSettings];
				cellMax = [myTableView cellForRowAtIndexPath:ipMax];
				((SliderCell *)cellMax).slider.value = [defaults floatForKey:@"MaxIntervalKey"];
				((SliderCell *)cellMax).lblValue.text = [NSString stringWithFormat:@"%.2f", [defaults floatForKey:@"MaxIntervalKey"]];
			}
			
			break;
		case kFNS_MaxInterval:
			[defaults setFloat:((UISlider *)sender).value forKey:@"MaxIntervalKey"];
			
			if ([defaults floatForKey:@"MinIntervalKey"] > [defaults floatForKey:@"MaxIntervalKey"])
			{
				UITableViewCell *cellMin;
				NSIndexPath *ipMin;
				
				[defaults setFloat:[defaults floatForKey:@"MaxIntervalKey"] forKey:@"MinIntervalKey"];
				ipMin = [NSIndexPath indexPathForRow:kFNS_MinInterval inSection:kFrightNightSettings];
				cellMin = [myTableView cellForRowAtIndexPath:ipMin];
				((SliderCell *)cellMin).slider.value = [defaults floatForKey:@"MinIntervalKey"];
				((SliderCell *)cellMin).lblValue.text = [NSString stringWithFormat:@"%.2f", [defaults floatForKey:@"MinIntervalKey"]];
			}
			
			break;
		case kFNS_TotalDuration:
			[defaults setFloat:((UISlider *)sender).value forKey:@"TotalDurationKey"];
			break;
		default:
			break;
	}
	
	curDict = [[mySettingsArray objectAtIndex:kFrightNightSettings] objectAtIndex:((UISlider *)sender).tag];
	UITableViewCell *cell;
	NSIndexPath *ip = [NSIndexPath indexPathForRow:((UISlider *)sender).tag inSection:kFrightNightSettings];
	cell = [myTableView cellForRowAtIndexPath:ip];
	
	if ([[curDict objectForKey:@"Exponential"] boolValue])
		((SliderCell *)cell).lblValue.text = [NSString stringWithFormat:@"%2.2f", (pow(((SliderCell *)cell).slider.value, 3) + 0.1)];
	else
		((SliderCell *)cell).lblValue.text = [NSString stringWithFormat:@"%2.2f", ((SliderCell *)cell).slider.value];
}

-(void)pressedDetailScareSound:(id)sender
{
	Sound *snd = [[Sound alloc] init];
	
	snd.name = [NSString stringWithFormat:@"SndScare%.2d", ((UIButton *)sender).tag];
	[snd playSound];
}

-(void)pressedDetailPicture:(id)sender
{
	[imgPreview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicScare%.2d.png", ((UIButton *)sender).tag]]];
	window.hidden = NO;
}

-(void)pressedDetailSafePicture:(id)sender
{
	[imgPreview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicSafe%.2d.png", ((UIButton *)sender).tag]]];
	window.hidden = NO;
}

-(void)previewSound:(NSString *)sound
{
	Sound *snd = [[Sound alloc] init];
	
	snd.name = sound;
	[snd playSound];
}


-(IBAction)closePicturePreview
{
	window.hidden = YES;
}

@end
