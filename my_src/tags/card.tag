<card>
  <!-- Card -->

  <div class="card-dims card">

        <div class="image thumb">
          <img src='{ imgHtml }' alt="">
        </div>
        <div class="content">

          <div class="mini custom ui icon top right floated pointing dropdown button">
            <i class="ellipsis horizontal icon"></i>
            <div class="menu">
              <div class="item">Change Image</div>
              <div class="item">View Detail</div>
              <div class="item">Start Presentation</div>
              <div class="ui divider"></div>
              <div class="item">Help</div>
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
    var belongsToRowId  = this.parent.row.id

// Set methods //
    set_cardDimensions () {
      this.cardImgHeight  = riot.store.cardHeight
      this.cardImgWidth   = riot.store.cardWidth
      this.imgHtml        = "http://placehold.it/" + this.cardImgWidth + "x" + this.cardImgHeight
      this.update()
    }

// On Tag mount //
    this.on('mount', function() {
    // Mount semantic-ui interaction configuration //
      $('.custom.ui.dropdown')
        .dropdown({
          "direction"   : "upward"
        })
      $('.card-dims')
        .css({
          "width"  : this.cardImgWidth
        })
      })

// Initialise state //
    this.set_cardDimensions()

// Make reactive to state changes in app //
    riot.store.on('update_dims',this.set_cardDimensions)

</script>

</card>
