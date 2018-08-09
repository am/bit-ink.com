<template>
  <div class="page">
    <header class="header">
      <img class="header__image" src="/am.png" alt="am">
      <h1 class="header__title">antonio miranda</h1>
      <h2 class="header__title">front end developer</h2>
    </header>
    <nav class="navigation">
      <ul class="navigation__list">
        <li v-for="link in this.links" class="navigation__item">
          <a class="navigation__link" :href="link.href" :target="link.target">{{ link.text }}</a>
        </li>
      </ul>
    </nav>
  </div>
</template>

<style lang="sass">
@import url('https://fonts.googleapis.com/css?family=Martel+Sans:400,700')

$swatch-yellow: #F6F792
$swatch-black: #333745
$swatch-cyan: #77C4D3
$swatch-light-cyan: #DAEDE2
$swatch-red: #EA2E49

html, body
  font-size: 1em
  line-height: 1.2em
  font-family: 'Martel Sans', sans-serif
  margin: 0
  padding: 0
  background-color: $swatch-light-cyan

.page
  display: flex
  flex-direction: column
  width: 100vw
  height: 100vh

$mid-line: 30vw

.header

  padding-left: $mid-line / 2
  margin: 6vh 0
  color: $swatch-black

.navigation
  padding-left: $mid-line / 2

.header__image
  width: 100px

.header__title
  font-size: 1em

.navigation__list
  list-style: none
  padding: 0

.navigation__item
  overflow: hidden
  margin-left: -0.5em

.navigation__link
  color: $swatch-cyan
  font-size: 2em
  line-height: 1.3em
  text-decoration: none
  margin-left: -1em
  transition: all 150ms ease-in-out

  &:hover
    color: $swatch-red
    margin-left: 0

  &:before
    content: '— '

@media (min-width:320px)
  // smartphones, iPhone, portrait 480x320 phones
@media (min-width:481px)
  // portrait e-readers (Nook/Kindle), smaller tablets @ 600 or @ 640 wide. */ }
@media (min-width:641px)
  // portrait tablets, portrait iPad, landscape e-readers, landscape 800x480 or 854x480 phones */ }
@media (min-width:961px)
  // tablet, landscape iPad, lo-res laptops ands desktops
  .header
    padding-right: 100 - $mid-line
    text-align: right

  .navigation
    padding-left: $mid-line

@media (min-width:1025px)
  // big landscape tablets, laptops, and desktops
@media (min-width:1281px)
  // hi-res laptops and desktops

</style>


<script>
export default {
  data: function() {
    return {
      links: [
        // { text: 'cv', href: '/cv', target: '_self' },
        { text: 'github', href: 'https://github.com/am', target: '_blank' },
        { text: 'twitter', href: 'https://www.twitter.com/ammutable', target: '_blank' },
        { text: 'flickr', href: 'https://www.flickr.com/photos/95126201', target: '_blank' },
        { text: 'contact', href: 'mailto:antsmiranda@gmail.com', target: '_blank' },
      ]
    }
  }
}
</script>
