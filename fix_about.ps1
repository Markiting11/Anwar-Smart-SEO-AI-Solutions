# Fix About Page Header Script

$basePath = "c:\Users\MAKKAH\Desktop\Anwar-seo\vanilla-site"
$indexPath = Join-Path $basePath "index.html"
$aboutPath = Join-Path $basePath "about.html"

# 1. Get the Standard Header from index.html
$indexContent = Get-Content $indexPath -Raw

$startMarker = "<!-- Navbar -->"
$endMarker = "<!-- Main Content -->"

$startIdx = $indexContent.IndexOf($startMarker)
$endIdx = $indexContent.IndexOf($endMarker)

if ($startIdx -eq -1 -or $endIdx -eq -1) {
    Write-Host "Error: Could not find Navbar in index.html"
    exit
}

$navbarHtml = $indexContent.Substring($startIdx, $endIdx - $startIdx).Trim()

# 2. Modify Active States for About Page

# Define classes
$homeActiveClass = "text-primary bg-primary/10 hover:bg-primary/20"
$homeInactiveClass = "text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10"

$mobileActiveClass = "text-accent-foreground bg-accent shadow-sm"
$mobileInactiveClass = "text-navbar-foreground/80 hover:text-navbar-foreground hover:bg-navbar-foreground/10"

# Desktop: Make Home inactive
# We use regex for safer replacement if exact whitespace matches are tricky, but string replace is safer if we match exact substring
# Let's try to match the exact string we know is there from previous reads

# Replace Home Active with Inactive
$navbarHtml = $navbarHtml.Replace(
    "href=""index.html""
                        class=""px-3 py-2 rounded-lg text-sm font-medium transition-all $homeActiveClass""",
    "href=""index.html""
                        class=""px-3 py-2 rounded-lg text-sm font-medium transition-all $homeInactiveClass"""
)

# Replace About Inactive with Active
$navbarHtml = $navbarHtml.Replace(
    "href=""about.html""
                        class=""px-3 py-2 rounded-lg text-sm font-medium transition-all $homeInactiveClass""",
    "href=""about.html""
                        class=""px-3 py-2 rounded-lg text-sm font-medium transition-all $homeActiveClass"""
)

# Mobile: Make Home inactive
$navbarHtml = $navbarHtml.Replace(
    "href=""index.html""
                    class=""flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all $mobileActiveClass""",
    "href=""index.html""
                    class=""flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all $mobileInactiveClass"""
)

# Mobile: Make About active
$navbarHtml = $navbarHtml.Replace(
    "href=""about.html""
                    class=""flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all $mobileInactiveClass""",
    "href=""about.html""
                    class=""flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all $mobileActiveClass"""
)

# 3. Read and Fix about.html
$aboutContent = Get-Content $aboutPath -Raw

$scriptEndMarker = "</script>"
$heroMarker = "<!-- Hero Section -->"

$heroIdx = $aboutContent.IndexOf($heroMarker)
if ($heroIdx -eq -1) {
    Write-Host "Error: Could not find Hero Section in about.html"
    exit
}

$scriptEndIdx = $aboutContent.LastIndexOf($scriptEndMarker, $heroIdx)
if ($scriptEndIdx -eq -1) {
    Write-Host "Error: Could not find closing script tag in about.html"
    exit
}

$insertionPoint = $scriptEndIdx + $scriptEndMarker.Length

$preContent = $aboutContent.Substring(0, $insertionPoint)
$postContent = $aboutContent.Substring($heroIdx)

$newStructure = @"

    </head>

    <body class="bg-background text-foreground antialiased">

    $navbarHtml

    <!-- Main Content -->
    <div class="min-h-screen bg-background">

"@

$finalContent = $preContent + $newStructure + $postContent

# 4. Write back
$finalContent | Set-Content $aboutPath -NoNewline

Write-Host "Successfully updated about.html"
