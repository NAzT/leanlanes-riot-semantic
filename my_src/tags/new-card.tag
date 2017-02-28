<new-card>

  <div class="ui card card-dims">
    <div class="content">
      <div class="custom-new-card img-placeholder">
          <p class="custom-new-card text">Upload</p>
          <form>
              <input id="cardFileUpload" ref="input_image_upload" type="file" onchange="{imgUpload}" /> 
          </form>
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

  this.cardImgWidth   = riot.store.cardWidth

  this.on('mount', function() {
    $('.card-dims')
      .css({
        "width"  : this.cardImgWidth
      })
    })

  newCard() {
    // Get data passed from parent tag via opts
    let rowId = opts.row_id
    // Get data from interface
    let newCardName = this.refs.input_new_card_name.value
    let newCardDetails = this.refs.txtfield_new_card_details.value

    // Add card data to database
    cardDatabase.setCardText(rowId,newCardName,newCardDetails)
    cardDatabase.addCard()

    // Reset the form fields
    this.refs.input_new_card_name.value = ''
    this.refs.txtfield_new_card_details.value = ''
    $("#cardFileUpload").replaceWith($("#cardFileUpload").val('').clone(true));
  }

  imgUpload(e) {
    // 
    let file = e.target.files[0]
    cardDatabase.setCardImageFile(file)
  }

  var cardDatabase = (function () {
        // Properties
        let _rowId = "" 
        let _selectedImgFile = "" // The image file
        let _imgFileLoaded = false // returns whether a file was uploaded
        let _cardData = {
          name : "",
          details : "",
          url : "",
          imgCardPresent : false
        }
        var _updates = {} 
        
        // PRIVATE METHODS //
        // Adds a new card to Firebase
        function _doUpdate(ud,cd,bounceBack) {
          let newCardKey = ""
          console.log(cd)

          if (cd.imgCardPresent == true) {
              let newCardImgName = _selectedImgFile.name
              let newCardImgStorageRef = firebase.storage().ref('card-images/' + newCardImgName)
              let uploadTask = newCardImgStorageRef.put(_selectedImgFile)

              uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED,
                function(snapshot) {

                }, function(error) {
                  console.log(error)
                }, function() {
                  cd.url = uploadTask.snapshot.downloadURL
                  bounceBack(ud,cd)
              })
            } else {
              bounceBack(ud,cd)
            }
        }

        function _uploadText(ud,cd) {
            newCardKey = firebase.database().ref().child('cards').push().key
            ud['/cards/' + newCardKey] = cd
            ud['/rows-cards/' + _rowId + '/' + newCardKey] = cd
            firebase.database().ref().update(ud)
        }
        
        // PUBLIC METHODS //
        function addCard() {
          _doUpdate(_updates,_cardData,_uploadText)
        }
 
        function setCardText(rid,cn,cd) {
            _rowId = rid
            _cardData.name = cn
            _cardData.details = cd
        }

        function setCardImgObj(f) {
            _selectedImgFile = f
            _cardData.imgCardPresent = true
        }
 
        return {
            // API
            setCardText       : setCardText,
            setCardImageFile  : setCardImgObj,
            addCard           : addCard
        }
 
    })()

  </script>

</new-card>
