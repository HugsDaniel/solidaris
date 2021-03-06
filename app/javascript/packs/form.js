import SmoothScroll from 'smooth-scroll';

let cards = document.querySelectorAll('.js-category-choice');

cards.forEach((card) => {
  card.addEventListener('click', function(e){
    cards.forEach((card) => {
      card.querySelector('.overlay-2').classList.remove('card-active')
    });
    card.querySelector('.overlay-2').classList.add('card-active');
  });
});

var scroll = new SmoothScroll('a[data-scroll]', {
  speed: 2000,
  easing: 'easeOutQuint'
});

console.log(scroll);


var scroll2 = new SmoothScroll('.scroll',{
    header: '[data-scroll-header]'
  });
