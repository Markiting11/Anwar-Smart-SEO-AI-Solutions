document.addEventListener('DOMContentLoaded', () => {
  // Initialize Lucide icons
  lucide.createIcons();

  // Mobile Menu Toggle
  const menuButton = document.getElementById('mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');
  const menuIcon = menuButton.querySelector('[data-lucide="menu"]');
  const closeIcon = menuButton.querySelector('[data-lucide="x"]');

  if (menuButton && mobileMenu) {
    menuButton.addEventListener('click', () => {
      const isHidden = mobileMenu.classList.contains('hidden');
      if (isHidden) {
        mobileMenu.classList.remove('hidden');
        // Swap icons logic if needed, or just toggle visibility if both are present
        // For simplicity, we might just re-render icons or toggle classes
      } else {
        mobileMenu.classList.add('hidden');
      }
    });
  }

  // Close mobile menu when clicking a link
  const mobileLinks = mobileMenu?.querySelectorAll('a');
  mobileLinks?.forEach(link => {
    link.addEventListener('click', () => {
      mobileMenu.classList.add('hidden');
    });
  });
});
