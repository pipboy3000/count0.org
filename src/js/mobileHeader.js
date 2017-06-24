import { q } from './dom.js'

export default function() {
window.addEventListener('scroll', (e) => {
  const header = q('.layout-document > .header');
  const header_height = getComputedStyle(header).height.split('px')[0];

  if (window.pageYOffset < (header_height)) {
    if (header.classList.contains('-mini')) {
      header.classList.remove('-mini');
    }
  } 

  if (window.pageYOffset > (header_height / 2)) {
    if (!header.classList.contains('-mini')) {
      header.classList.add('-mini');
    }
  }
}, false);
}