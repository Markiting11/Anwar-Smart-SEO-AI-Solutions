import os
import glob
import re

folder = r'c:\Users\MAKKAH\Desktop\Anwar-Seo'

pages = [
    'index', 'about', 'services', 'portfolio', 'blog',
    'blog-post', 'contact', 'testimonials', 'work-samples',
    'auth', 'admin', '404'
]

files = [f for f in glob.glob(os.path.join(folder, '*.html')) if 'index_backup' not in f]
updated = []

for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    original = content

    for page in pages:
        if page == 'index':
            # href="index.html" or href='index.html'
            content = re.sub(
                r"(href=[\"'])index\.html(#[^\"']*)?([\"'])",
                lambda m: m.group(1) + '/' + (m.group(2) or '') + m.group(3),
                content
            )
        else:
            # href="page.html" or href='page.html' (with or without anchor)
            content = re.sub(
                r"(href=[\"'])" + re.escape(page) + r"\.html(#[^\"']*)?([\"'])",
                lambda m, p=page: m.group(1) + p + (m.group(2) or '') + m.group(3),
                content
            )
            # JavaScript: 'page.html' or "page.html" (window.location.href = 'page.html')
            content = re.sub(
                r"([\"'])" + re.escape(page) + r"\.html([\"'])",
                lambda m, p=page: m.group(1) + p + m.group(2),
                content
            )
            # Template literal: `page.html?
            content = re.sub(
                re.escape(page) + r"\.html(\?)",
                page + r"\1",
                content
            )
            # fetch('page.html') or fetch("page.html")
            content = re.sub(
                r"(fetch\([\"'])" + re.escape(page) + r"\.html([\"']\))",
                lambda m, p=page: m.group(1) + p + m.group(2),
                content
            )

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        updated.append(os.path.basename(filepath))

print('Updated files:')
for u in updated:
    print(' -', u)
print(f'Total: {len(updated)} files updated')

# Final verify
print('\nFinal verification:')
found = False
for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    for page in pages:
        if page + '.html' in content:
            lines = content.splitlines()
            for i, line in enumerate(lines, 1):
                if page + '.html' in line:
                    print(f'  {os.path.basename(filepath)} L{i}: {line.strip()[:100]}')
            found = True
if not found:
    print('  All clean! No .html references remaining.')
