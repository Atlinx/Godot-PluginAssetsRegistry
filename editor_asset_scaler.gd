extends Reference

# Scales an asset based on the dpi of the screen
static func scale_asset(asset, screen: int = -1):
	if asset is Font:
		OS.get_screen_dpi(screen)
	elif asset is Image:
		pass

static func scale_dynamic_font(font: DynamicFont, screen: int = -1):
	font.size = OS.get_screen_dpi(screen) 
	pass
	
static func scale_image(image: Image, screen: int = -1):
	pass
