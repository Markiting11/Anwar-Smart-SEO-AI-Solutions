# PowerShell script to update header navigation in all HTML files

$standardHeader = @'
    <!-- Navbar -->
    <nav class="sticky top-0 z-50 bg-navbar border-b border-navbar shadow-sm">
        <div class="container mx-auto px-4">
            <div class="flex items-center justify-between h-16">
                <a href="index.html"
                    class="flex items-center gap-2 text-xl font-bold text-navbar-foreground hover:opacity-80 transition-opacity">
                    <img src="assets/logo.png" alt="Anwar Ali Logo" class="w-10 h-10 rounded-full">
                    <span>Anwar Ali</span>
                </a>

                <!-- Desktop Navigation -->
                <div class="hidden md:flex items-center space-x-1">
                    <a href="index.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Home
                    </a>
                    <a href="about.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        About
                    </a>
                    <a href="services.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Services
                    </a>
                    <a href="portfolio.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Portfolio
                    </a>
                    <a href="work-samples.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Work
                    </a>
                    <a href="testimonials.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Reviews
                    </a>
                    <a href="blog.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Blog
                    </a>
                    <a href="contact.html"
                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                        Contact
                    </a>

                    <a href="contact.html">
                        <button
                            class="ml-2 inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-9 px-4 py-2 shadow-md hover:shadow-lg transition-shadow bg-primary hover:bg-primary/90 text-primary-foreground">
                            <i data-lucide="mail" class="w-4 h-4 mr-2"></i>
                            Hire Me
                        </button>
                    </a>
                </div>

                <!-- Mobile Menu Button -->
                <button id="mobile-menu-button"
                    class="md:hidden p-2 rounded-md text-navbar-foreground hover:bg-navbar-foreground/10">
                    <i data-lucide="menu" size="24"></i>
                    <i data-lucide="x" size="24" class="hidden"></i>
                </button>
            </div>

            <!-- Mobile Navigation -->
            <div id="mobile-menu"
                class="hidden md:hidden pb-4 animate-fade-in border-t border-navbar-foreground/20 mt-2 pt-2">
                <a href="index.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="home" class="w-4 h-4"></i>
                    Home
                </a>
                <a href="about.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="user" class="w-4 h-4"></i>
                    About Me
                </a>
                <a href="services.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="briefcase" class="w-4 h-4"></i>
                    Services
                </a>
                <a href="portfolio.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="folder-open" class="w-4 h-4"></i>
                    Portfolio
                </a>
                <a href="work-samples.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="file-text" class="w-4 h-4"></i>
                    Work Samples
                </a>
                <a href="testimonials.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="message-circle" class="w-4 h-4"></i>
                    Testimonials
                </a>
                <a href="blog.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="file-text" class="w-4 h-4"></i>
                    Blog
                </a>
                <a href="contact.html"
                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">
                    <i data-lucide="mail" class="w-4 h-4"></i>
                    Contact
                </a>
                <a href="contact.html">
                    <button
                        class="w-full mt-3 inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 shadow-md bg-primary hover:bg-primary/90 text-primary-foreground">
                        <i data-lucide="mail" class="w-4 h-4 mr-2"></i>
                        Hire Me
                    </button>
                </a>
            </div>
        </div>
    </nav>
'@

# List of files to update
$files = @(
    'about.html',
    'services.html',
    'portfolio.html',
    'work-samples.html',
    'testimonials.html',
    'blog.html',
    'blog-post.html',
    'contact.html'
)

$updatedCount = 0

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processing $file..." -ForegroundColor Cyan
        
        $content = Get-Content $file -Raw
        
        # Replace the navbar section using regex
        $pattern = '(?s)(\s*)<!-- Navbar -->.*?</nav>'
        $newContent = $content -replace $pattern, $standardHeader
        
        # Add active class for the current page
        $pageName = $file -replace '\.html$', ''
        if ($pageName -ne 'index' -and $pageName -ne 'blog-post') {
            # Update the link for the current page to have active styling
            $linkPattern = "href=`"$file`"\s+class=`"px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10`""
            $activeLink = "href=`"$file`" class=`"px-3 py-2 rounded-lg text-sm font-medium transition-all text-primary bg-primary/10 hover:bg-primary/20`""
            $newContent = $newContent -replace $linkPattern, $activeLink
        }
        
        Set-Content $file -Value $newContent -NoNewline
        Write-Host "✓ Updated $file" -ForegroundColor Green
        $updatedCount++
    } else {
        Write-Host "✗ File not found: $file" -ForegroundColor Red
    }
}

Write-Host "`n✓ Successfully updated $updatedCount files" -ForegroundColor Green
