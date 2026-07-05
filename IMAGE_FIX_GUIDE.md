# Image Placeholder Fix

## Issue
The image files in `vanilla-site/assets/` are empty (0 bytes). The original React project also has empty image files in `src/assets/`.

## Solution Options

### Option 1: Use Placeholder Image Service (Recommended)
Replace image paths with placeholder services that generate images automatically:

**For all images, update the `src` attributes to use one of these services:**

1. **Placeholder.com** (Simple solid colors):
   ```html
   <img src="https://via.placeholder.com/800x600/10b981/ffffff?text=Hero+Image" alt="Hero">
   ```

2. **Unsplash** (Real photos):
   ```html
   <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=600&fit=crop" alt="SEO Analytics">
   ```

3. **Lorem Picsum** (Random photos):
   ```html
   <img src="https://picsum.photos/800/600" alt="Portfolio">
   ```

### Option 2: Add Your Own Images
1. Replace the empty files in `vanilla-site/assets/` with actual images
2. Use the same filenames to avoid updating HTML
3. Recommended image sizes:
   - Hero images: 1200x800px
   - Service images: 800x600px
   - Portfolio images: 600x400px
   - Testimonial avatars: 200x200px

### Quick Fix Script
Run this PowerShell script to update all HTML files to use placeholder images:

```powershell
# Navigate to vanilla-site directory
cd "c:\Users\MAKKAH\Desktop\Anwar-seo\vanilla-site"

# Create a mapping of images to Unsplash URLs
$imageMap = @{
    "hero-profile.jpg" = "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800&h=600&fit=crop"
    "local-seo-analytics.jpg" = "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=600&fit=crop"
    "local-seo-search.jpg" = "https://images.unsplash.com/photo-1432888622747-4eb9a8f2c293?w=800&h=600&fit=crop"
    "link-building-network.jpg" = "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=600&fit=crop"
    "about-hero-seo-expert.jpg" = "https://images.unsplash.com/photo-1556761175-b413da4baf72?w=800&h=600&fit=crop"
    "local-citations-infographic.jpg" = "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=600&fit=crop"
    "seo-growth-metrics.jpg" = "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=600&fit=crop"
}

# Update each HTML file
Get-ChildItem -Filter "*.html" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    foreach ($key in $imageMap.Keys) {
        $content = $content -replace "assets/$key", $imageMap[$key]
    }
    Set-Content $_.FullName -Value $content
}
```

## Current Status
- ✅ Image file structure is correct
- ❌ Image files are empty (0 bytes)
- ✅ HTML paths are correct
- ⚠️ Need to add actual image content

## Recommended Action
Use Option 1 (Placeholder Service) for immediate results, then replace with real images later.
