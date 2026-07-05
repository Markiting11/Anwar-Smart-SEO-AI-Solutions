import os

def fix_about_page():
    base_path = r"c:\Users\MAKKAH\Desktop\Anwar-seo\vanilla-site"
    index_path = os.path.join(base_path, "index.html")
    about_path = os.path.join(base_path, "about.html")

    # 1. Get the Standard Header from index.html
    with open(index_path, 'r', encoding='utf-8') as f:
        index_content = f.read()
    
    # Extract Navbar (approx lines 75-194)
    start_marker = '<!-- Navbar -->'
    end_marker = '<!-- Main Content -->'
    
    start_idx = index_content.find(start_marker)
    end_idx = index_content.find(end_marker)
    
    if start_idx == -1 or end_idx == -1:
        print("Error: Could not find Navbar in index.html")
        return

    navbar_html = index_content[start_idx:end_idx].strip()
    
    # 2. Modify Active States for About Page
    
    # Desktop: Make Home inactive
    home_active_class = 'text-primary bg-primary/10 hover:bg-primary/20'
    home_inactive_class = 'text-navbar-foreground/80 hover:text-primary hover:bg-navbar-foreground/10'
    
    # We need to be careful with string replacement to target specific links
    # Let's replace the specific Home link class
    navbar_html = navbar_html.replace(
        f'href="index.html"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all {home_active_class}"',
        f'href="index.html"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all {home_inactive_class}"'
    )
    
    # Desktop: Make About active
    navbar_html = navbar_html.replace(
        f'href="about.html"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all {home_inactive_class}"',
        f'href="about.html"\n                        class="px-3 py-2 rounded-lg text-sm font-medium transition-all {home_active_class}"'
    )
    
    # Mobile: Make Home inactive
    mobile_active_class = 'text-accent-foreground bg-accent shadow-sm'
    mobile_inactive_class = 'text-navbar-foreground/80 hover:text-navbar-foreground hover:bg-navbar-foreground/10'
    
    navbar_html = navbar_html.replace(
        f'href="index.html"\n                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all {mobile_active_class}"',
        f'href="index.html"\n                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all {mobile_inactive_class}"'
    )
    
    # Mobile: Make About active
    navbar_html = navbar_html.replace(
        f'href="about.html"\n                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all {mobile_inactive_class}"',
        f'href="about.html"\n                    class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium transition-all {mobile_active_class}"'
    )

    # 3. Read and Fix about.html
    with open(about_path, 'r', encoding='utf-8') as f:
        about_content = f.read()
        
    # Find insertion point
    script_end_marker = '</script>'
    hero_marker = '<!-- Hero Section -->'
    
    # Find the last </script> before Hero Section
    hero_idx = about_content.find(hero_marker)
    if hero_idx == -1:
        print("Error: Could not find Hero Section in about.html")
        return
        
    script_end_idx = about_content.rfind(script_end_marker, 0, hero_idx)
    if script_end_idx == -1:
        print("Error: Could not find closing script tag in about.html")
        return
        
    insertion_point = script_end_idx + len(script_end_marker)
    
    # Construct new content
    pre_content = about_content[:insertion_point]
    post_content = about_content[hero_idx:]
    
    new_structure = f"""
    </head>

    <body class="bg-background text-foreground antialiased">

    {navbar_html}

    <!-- Main Content -->
    <div class="min-h-screen bg-background">

    """
    
    final_content = pre_content + new_structure + post_content
    
    # 4. Write back
    with open(about_path, 'w', encoding='utf-8') as f:
        f.write(final_content)
        
    print("Successfully updated about.html")

if __name__ == "__main__":
    fix_about_page()
