

if ($( window ).width() >= 1024) {
  gsap.from(".img-1", {duration: 3, x: 300, opacity: 0, scale: 0.5});
  gsap.from(".img-2", {duration: 3, x: 300, opacity: 0, scale: 0.5});
}
 window.addEventListener('load', AOS.refresh)

 AOS.init({disable: 'mobile'});
if (this.hasAnimateOnScrollElements && !this.aosRefreshed && AOS !== undefined) {
    this.aosRefreshed = true;
    AOS.refresh();
}

ScrollReveal().reveal('.banner-text,.section-2-text,.section-3-text,.section-4-text', { delay: 500, distance: '50px',easing: 'ease-in',interval: 300 });
function mailboxAnime (el) {
    $('.mailbox').addClass('animated flipInX');
}

ScrollReveal().reveal('.section-3-text', { afterReveal: mailboxAnime });
function tempboxanime (el) {
    $('.clrbox').addClass('animated flipInY');
}

ScrollReveal().reveal('.section-4-text', { afterReveal: tempboxanime });
//Get the button
var mybutton = document.getElementById("scrollTop");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
     mybutton.style.display = "none";
     // $("#scrollTop").delay(2500).hide();
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;


}
