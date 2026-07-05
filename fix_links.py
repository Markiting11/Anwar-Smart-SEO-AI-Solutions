import os
import glob

folder = r'c:\Users\MAKKAH\Desktop\Anwar-Seo'

replacements = [
    ('href="index.html"', 'href="/"'),
    ('href="about.html"', 'href="about"'),
    ('href="services.html"', 'href="services"'),
    ('href="portfolio.html"', 'href="portfolio"'),
    ('href="blog.html"', 'href="blog"'),
    ('href="blog-post.html"', 'href="blog-post"'),
    ('href="contact.html"', 'href="contact"'),
    ('href="testimonials.html"', 'href="testimonials"'),
    ('href="work-samples.html"', 'href="work-samples"'),
    ('href="auth.html"', 'href="auth"'),
    ('href="admin.html"', 'href="admin"'),
    ('href="404.html"', 'href="404"'),
]

files = [f for f in glob.glob(os.path.join(folder, '*.html')) if 'index_backup' not in f]
updated = []

for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    original = content
    for old, new in replacements:
        content = content.replace(old, new)
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        updated.append(os.path.basename(filepath))

print('Updated files:')
for u in updated:
    print(' -', u)
print(f'Total: {len(updated)} files updated')
