# Fix Headers Script - Manually update each file with correct header

$files = @(
    @{File="portfolio.html"; Active="Portfolio"},
    @{File="work-samples.html"; Active="Work"},
    @{File="about.html"; Active="About"},
    @{File="testimonials.html"; Active="Reviews"},
    @{File="blog.html"; Active="Blog"},
    @{File="contact.html"; Active="Contact"}
)

foreach ($item in $files) {
    $file = $item.File
    $activePage = $item.Active
    
    Write-Host "Processing $file with active page: $activePage"
    
    # Read the file
    $content = Get-Content $file -Raw
    
    # Find the navbar section (from <!-- Navbar --> to </nav>)
    $navbarStart = $content.IndexOf("<!-- Navbar -->")
    $navbarEnd = $content.IndexOf("</nav>", $navbarStart) + 6
    
    if ($navbarStart -ge 0 -and $navbarEnd -gt $navbarStart) {
        Write-Host "Found navbar section in $file"
        Write-Host "Start: $navbarStart, End: $navbarEnd"
    } else {
        Write-Host "ERROR: Could not find navbar section in $file"
    }
}
