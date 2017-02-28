<card>
  <!-- Card -->

  <div id={ id } class="card-dims card">

        <div class="image thumb">
          <img show={ imgIsThere } src='{ url }' alt="">
        </div>
        <div class="content">

          <div class="mini custom ui icon top right floated pointing dropdown button">
            <i class="ellipsis horizontal icon"></i>
            <div class="menu">
              <div class="item">Change Image</div>
              <div class="item">View Detail</div>
              <div class="item">Start Presentation</div>
              <div class="ui divider"></div>
              <div onclick={removeCard} class="item">Delete</div>
            </div>
          </div>

          <div class="header">
            { title }
          </div>
          <div class="custom-card description">
            { detail }
          </div>
        </div>

  </div>

  <style>
/*  Styles are set in the parent ROW tag */

  </style>


<script>
// Set props //
    this.title          = this.card.title
    this.detail         = this.card.detail
    this.url            = this.card.url
    this.id             = this.card.id
    this.cardsRowId     = this.parent.row.id
    this.imgIsThere     = this.card.imgForCard
    
// Set methods //
    removeCard() {
      let ud = {}

      ud['/cards/' + this.id] = null
      ud['/rows-cards/' + this.cardsRowId + '/' + this.id] = null
      firebase.database().ref().update(ud)
    }

    set_cardDimensions () {
      this.cardImgHeight  = riot.store.cardHeight
      this.cardImgWidth   = riot.store.cardWidth
      this.imgHtml        = "http://placehold.it/" + this.cardImgWidth + "x" + this.cardImgHeight
      this.update()
    }

// On Tag mount //
    this.on('mount', function() {
    // Mount semantic-ui interaction configuration //
      $('.card-dims')
        .css({
          "width"  : this.cardImgWidth
        })
      $('.ui.dropdown')
        .dropdown()
      })

    this.on('unmount', function() {
      $('.ui.dropdown')
        .dropdown()
      })

// Initialise state //
    this.set_cardDimensions()

// Make reactive to state changes in app //
    riot.store.on('update_dims',this.set_cardDimensions)

</script>

</card>
