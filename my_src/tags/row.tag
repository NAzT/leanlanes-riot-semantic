<row>

  <div id="grid-container">

    <div each={row in rows} class="new-width" id={row.id}>

          <div class="row-header" dblclick={editTitle}>
              <div>
                <h3 hide={row.selected}>{row.name}</h3>
                <p hide={row.selected}>{row.details}</p>
                <div show={row.selected} class="ui form">
                    <div class="field">
                      <label>Title</label>
                      <input show={row.selected} ref="input_row_title" type="text" value={row.title}>
                    </div>
                    <div class="field">
                      <label>Details</label>
                      <textarea rows="3" ref="txtarea_row_detail" value={row.detail}></textarea>
                    </div>
                    <div onclick={saveRowChange} class="ui button" tabindex="0">Update</div>
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

    /* ROWS */
    var rowsRef = firebase.database().ref().child('rows')
    self = this
    
    setup_Rows () {  
      rowsRef.on('child_added', function(r) {
        let rowObj = {}

        rowObj = {
          id : r.key,
          name : r.val().name,
          details : r.val().details,
          cards : []
        }
        riot.store.rows.push(rowObj)
        addCards(r.key)
        self.update()
      })

      rowsRef.on('child_changed', function(r){
        riot.store.rows.forEach(function(row, i) {
          if (row.id == r.key) {
            riot.store.rows[i].name = r.val().name,
            riot.store.rows[i].details = r.val().details
            self.update()
          }
        })
      })

      function addCards(rowId) {
        let cardsRef = firebase.database().ref('rows-cards/' + rowId)
        riot.store.rows.forEach(function(row, i) {
          if (row.id == rowId) {
            cardsRef.on('child_added', function(c) {
              let cardObj = {}

              cardObj = {
                id : c.key,
                title : c.val().name,
                detail : c.val().details
              }

              riot.store.rows[i].cards.push(cardObj)
              self.update()
            })
          }
        })
      }
    }

    /* INTERACTIONS */
    editTitle(e) {
      event.item.row.selected = !event.item.row.selected

      let rn = event.item.row.name
      let rd = event.item.row.details
      let rid = event.item.row.id

      this.refs.input_row_title.value = rn
      this.refs.txtarea_row_detail.value = rd
    }

    saveRowChange(e) {
      let rn = this.refs.input_row_title.value
      let rd = this.refs.txtarea_row_detail.value
      let rid = event.item.row.id

      var rowData = {
        name : rn,
        details : rd
      }

      var updates = {}
      updates['/rows/' + rid] = rowData

      this.refs.input_row_title.value = ''
      this.refs.txtarea_row_detail.value = '' 

      firebase.database().ref().update(updates)

      this.editTitle()
    }

    this.setup_Rows()

  </script>

</row>
