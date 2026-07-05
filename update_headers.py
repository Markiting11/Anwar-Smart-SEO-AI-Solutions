import os
import re

# Standard header HTML (without the opening and closing nav tags)
STANDARD_HEADER = '''    <!-- Navbar -->
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
'''

def update_header_in_file(filepath, current_page):
    """Update the header in a single HTML file"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find and replace the navbar section
    # Pattern to match from <!-- Navbar --> to </nav>
    pattern = r'(\s*)<!-- Navbar -->.*?</nav>'
    
    # Create the header with active state for current page
    header = STANDARD_HEADER
    
    # Add active class to the current page link
    if current_page != 'index.html':
        page_name = current_page.replace('.html', '')
        # Update the link for the current page to have active styling
        header = header.replace(
            f'<a href="{current_page}"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">',
            f'<a href="{current_page}"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-primary bg-primary/10 hover:bg-primary/20">'
        )
    else:
        # For index.html, make Home active
        header = header.replace(
            '<a href="index.html"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10">',
            '<a href="index.html"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all text-primary bg-primary/10 hover:bg-primary/20">'
        )
    
    # Replace the navbar
    new_content = re.sub(pattern, header, content, flags=re.DOTALL)
    
    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    return True

# Directory containing HTML files
html_dir = r'c:\Users\MAKKAH\Desktop\Anwar-seo\vanilla-site'

# List of HTML files to update (excluding 404.html, admin.html, auth.html)
html_files = [
    'index.html',
    'about.html',
    'services.html',
    'portfolio.html',
    'work-samples.html',
    'testimonials.html',
    'blog.html',
    'blog-post.html',
    'contact.html'
]

# Update each file
updated_files = []
for html_file in html_files:
    filepath = os.path.join(html_dir, html_file)
    if os.path.exists(filepath):
        try:
            update_header_in_file(filepath, html_file)
            updated_files.append(html_file)
            print(f'✓ Updated: {html_file}')
        except Exception as e:
            print(f'✗ Error updating {html_file}: {str(e)}')
    else:
        print(f'✗ File not found: {html_file}')

print(f'\n✓ Successfully updated {len(updated_files)} files')
print('Updated files:', ', '.join(updated_files))
