# Restore and Update All Headers Script
# This script copies the header from index_backup.html to all other pages

$sourceFile = "index_backup.html"

# Read the source file
$sourceContent = Get-Content $sourceFile -Raw

# Extract the header section (from <!-- Navbar --> to </nav>)
$headerStart = $sourceContent.IndexOf("    <!-- Navbar -->")
$headerEnd = $sourceContent.IndexOf("    </nav>", $headerStart) + 10  # +10 for "    </nav>"

if ($headerStart -lt 0 -or $headerEnd -lt $headerStart) {
    Write-Host "ERROR: Could not find header section in $sourceFile"
    exit 1
}

$standardHeader = $sourceContent.Substring($headerStart, $headerEnd - $headerStart)

Write-Host "Extracted header section ($($standardHeader.Length) characters)"
Write-Host ""

# Define files to update with their active page
$filesToUpdate = @(
    @{File="portfolio.html"; ActiveDesktop="Portfolio"; ActiveMobile="Portfolio"},
    @{File="work-samples.html"; ActiveDesktop="Work"; ActiveMobile="Work Samples"},
    @{File="about.html"; ActiveDesktop="About"; ActiveMobile="About Me"},
    @{File="testimonials.html"; ActiveDesktop="Reviews"; ActiveMobile="Testimonials"},
    @{File="blog.html"; ActiveDesktop="Blog"; ActiveMobile="Blog"},
    @{File="contact.html"; ActiveDesktop="Contact"; ActiveMobile="Contact"}
)

foreach ($item in $filesToUpdate) {
    $file = $item.File
    $activeDesktop = $item.ActiveDesktop
    $activeMobile = $item.ActiveMobile
    
    Write-Host "Processing $file..."
    
    if (!(Test-Path $file)) {
        Write-Host "  ERROR: File not found!"
        continue
    }
    
    # Read the file
    $content = Get-Content $file -Raw
    
    # Find the navbar section
    $navStart = $content.IndexOf("    <!-- Navbar -->")
    $navEnd = $content.IndexOf("    </nav>", $navStart)
    
    if ($navStart -lt 0 -or $navEnd -lt 0) {
        Write-Host "  ERROR: Could not find navbar section!"
        continue
    }
    
    $navEnd += 10  # Include "    </nav>"
    
    # Create the new header with correct active state
    $newHeader = $standardHeader
    
    # Update desktop navigation active state
    # Remove Home active state
    $newHeader = $newHeader -replace 'href="index\.html"[^>]*class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-primary bg-primary/10 hover:bg-primary/20"',
                                      'href="index.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10"'
    
    # Set the correct page as active in desktop nav
    $newHeader = $newHeader -replace "href=""$($activeDesktop.ToLower() -replace ' ', '-')\.html""[^>]*class=""px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10""",
                                      "href=""$($file)""
                        class=""px-3 py-2 rounded-lg text-sm font-medium transition-all text-primary bg-primary/10 hover:bg-primary/20"""
    
    # Update mobile navigation active state
    # Remove Home active state in mobile
    $newHeader = $newHeader -replace 'href="index\.html"[^>]*class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-accent-foreground bg-accent shadow-sm"',
                                      'href="index.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-navbar-foreground hover:bg-navbar-foreground/10"'
    
    # Replace the old header with the new one
    $newContent = $content.Substring(0, $navStart) + $newHeader + $content.Substring($navEnd)
    
    # Write the updated content
    $newContent | Set-Content $file -NoNewline
    
    Write-Host "  ✓ Updated successfully!"
}

Write-Host ""
Write-Host "All files updated!"
