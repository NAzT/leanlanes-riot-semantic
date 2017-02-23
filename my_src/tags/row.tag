<row>

  <div id="grid-container">

    <div each={row in rows} class="new-width" >

          <div class="row-header" dblclick={editTitle}>
              <div id={row.id}>
                <h3 hide={row.selected}>{row.name}</h3>
                <p hide={row.selected}>{row.details}</p>
                <div show={row.selected} class="ui form">
                    <div class="field">
                      <label>Title</label>
                      <input show={row.selected} ref="input_card_title" type="text" value={row.title}>
                    </div>
                    <div class="field">
                      <label>Details</label>
                      <textarea rows="3" ref="input_card_detail" value={row.detail}></textarea>
                    </div>
                    <div onclick={editTitle} class="ui button" tabindex="0">Update</div>
                </div>
              </div>
          </div>

          <div class="ui cards up-top">
            <virtual each={card in row.cards} data-is="card">
            </virtual>
            <virtual row_id={row.id} data-is="new-card">
            </virtual>
          </div>

          <div style="clear:both"></div>

    </div>

    <new-row></new-row>

  </div>

  <style>
    /* Styles */
    row #grid-container {
      overflow-x: auto;
    }
    row .new-width {
      width: 1800px;
/*    ^ temporarily sets width of the <row> tag until a programmatic option is implemented
        that can automatically define <row> width based on the number of Cards */
      margin: 20px 0px 20px 0px;
    }
    row div.row-header {
      width: 300px;
      float: left;
      display: inline-block;
      vertical-align: top;
      padding: 20px;
    }
    row div.up-top{
      float: left;
    }
    /* Card CSS set here, there's some issue with Semantic UI */
    div.custom-card {
      height: 40px;
      overflow-y: scroll;
    }
    input.custom-new-card {
      margin-bottom: 20px;
    }
    div.custom-new-card.img-placeholder {
      border-style: dashed;
      border-width: thin;
      border-color: grey;
      border-radius: 10px;
      position: relative;
      height: 100px;
      margin-bottom: 20px;
    }
    p.custom-new-card.text {
      color: grey;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      display: block;
    }
    div.custom-new-card.input {
      margin-bottom: 10px;
    }
  </style>

  <script>

    /* Properties */
    
    this.cardImgHeight = riot.store.cardHeight
    this.cardImgWidth = riot.store.cardWidth
    this.edit_title_state = false
    this.rows = riot.store.rows = []
    
    // First pass setting rows up
    setRows()

    // updates the interface with row changes
    watch_Rows () {
      this.rows = riot.store.rows
      console.log(this.rows)
      this.update()
    }
    
    // Make rows reactive to changes
    riot.store.on('set_new_rows',this.watch_Rows)

    // Interaction
    editTitle(e) {
        event.item.row.selected = !event.item.row.selected
    }

    function setRows() {
      var currRows = riot.store.rows
      var rowsRef = firebase.database().ref().child('rows')
      rowsRef.once('value', snap => {
        snap.forEach(item => { 
          currRows.push(item.val()) 
        })
      }).then(function() {
        riot.store.rows = currRows
        riot.store.trigger('set_new_rows')
      })
    }

  </script>

</row>
