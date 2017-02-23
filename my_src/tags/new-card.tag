<new-card>

  <div class="ui card card-dims">
    <div class="content">
      <div class="custom-new-card img-placeholder">
          <p class="custom-new-card text">Upload</p>
      </div>
      <div class="custom-new-card ui form header">
        <div class="custom-new-card ui mini fluid input field">
          <input ref="input_new_card_name" type="text" placeholder="Add card name">
        </div>
        <div class="custom-new-card ui mini fluid input field">
          <textarea ref="txtfield_new_card_details" rows="2" type="text" placeholder="Add details"></textarea>
        </div>
      </div>
      <div class="description">

      </div>
    </div>

    <div onclick={newCard} class="ui bottom attached button">
      <i class="add icon"></i>
      Add Card
    </div>
  </div>

  <style>
/*  Styles applied dynamically so set in the parent tag */

  </style>

  <script>

  this.rowId = opts.row_id

  newCard() {
    rowId = this.rowId
    newCardName = this.refs.input_new_card_name.value
    newCardDetails = this.refs.txtfield_new_card_details.value
    newCardKey = firebase.database().ref().child('cards').push().key

    var cardData = {
      name : newCardName,
      details : newCardDetails
    }

    // Write the new card's data simultaneously in the cards list and the row's card list.
    var updates = {}
    updates['/cards/' + newCardKey] = cardData
    updates['/rows-cards/' + rowId + '/' + newCardKey] = cardData

    this.refs.input_new_card_name.value = ''
    this.refs.txtfield_new_card_details.value = ''

    return firebase.database().ref().update(updates)
  }

  </script>

</new-card>
